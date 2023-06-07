----------------------- 输入函数后自动补全括号 ------------------------
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local handlers = require("nvim-autopairs.completion.handlers")
cmp.event:on(
  "confirm_done",   -- 当cmp发生confirm_done(即<C-m>)时自动补全括号
  cmp_autopairs.on_confirm_done({})
-- cmp_autopairs.on_confirm_done({
-- 	filetypes = {
-- 		-- "*" is a alias to all filetypes
-- 		["*"] = {
-- 			["("] = {
-- 				kind = {
-- 					cmp.lsp.CompletionItemKind.Function,
-- 					cmp.lsp.CompletionItemKind.Method,
-- 				},
-- 				handler = handlers["*"],
-- 			},
-- 		},
-- 		lua = {
-- 			["("] = {
-- 				kind = {
-- 					cmp.lsp.CompletionItemKind.Function,
-- 					cmp.lsp.CompletionItemKind.Method,
-- 				},
-- 				---@param char string
-- 				---@param item table item completion
-- 				---@param bufnr number buffer number
-- 				---@param rules table
-- 				---@param commit_character table<string>
-- 				handler = function(char, item, bufnr, rules, commit_character)
-- 					-- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
-- 				end,
-- 			},
-- 		},
-- 		-- Disable for tex
-- 		tex = false,
-- 	},
-- })
)

------------------------- 增加配对补全规则 --------------------------
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
autopairs.add_rules({
  -- 注释
  Rule("/* ", " */", { "c", "cpp", "css", "javascript", "php" }):with_pair(cond.not_inside_quote()),
  Rule("//", " ", { "c", "cpp", "javascript", "php" })
      :with_pair(cond.not_inside_quote())
      :replace_endpair(function(opts)
        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        if prev_2char:match("^/") then
          return "<bs><bs>// "
        elseif prev_2char:match("^%S") then
          return "<bs><bs> // "
        else
          return "<bs><bs>// "
        end
      end)
      :set_end_pair_length(0),
  Rule("#", "", { "python" })
      :with_pair(cond.not_inside_quote())
      :replace_endpair(function(opts)
        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        if prev_2char == "" then
          return " "
        elseif prev_2char == "  " then
          return " "
        elseif prev_2char:match("#") then
          return ""
        elseif prev_2char:match("%S%s") then
          return "<bs> # "
        elseif prev_2char:match("%S$") then
          return "<bs>  # "
        else
          return ""
        end
      end)
      :set_end_pair_length(0),
  -- 头文件<>
  Rule("<", ">", { "c", "cpp" }):with_pair(function(opts)
    if opts.line:match("#include") == "#include" then
      return true
    else
      return false
    end
  end),
  -- c++,vector<>
  Rule("<", ">", { "cpp" }):with_pair(cond.before_text("vector")),
  -- html <>
  Rule("<", ">", { "html" }),
  -- lua <
  Rule("<", ">", { "lua" }):with_pair(cond.before_text('"')),
  -- \t  \n
  Rule("\\t", "", { "c", "cpp", "php", "python" })
      :with_pair(cond.not_inside_quote())
      :replace_endpair(function(opts)
        return "<bs><bs>'\\t'"
      end)
      :set_end_pair_length(0),
  Rule("\\n", "", { "c", "cpp", "php", "python" })
      :with_pair(cond.not_inside_quote())
      :replace_endpair(function(opts)
        return "<bs><bs>'\\n'"
      end)
      :set_end_pair_length(0),

  -- 等号自动补空格
  Rule("=", "", { "-html" })
      :with_pair(cond.not_inside_quote())
  -- :with_pair(function(opts)
  -- 	local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
  -- 	-- if last_char:match("[%w%=%s]") then
  -- 	if last_char:match("%S") then
  -- 		return true
  -- 	end
  -- 	return false
  -- end)
      :replace_endpair(
        function(opts)
          local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
          local next_char = opts.line:sub(opts.col, opts.col)
          next_char = next_char == " " and "" or " "
          -- a == -> a ==
          if prev_2char:match("[=<>+%-*/%%!]$") then
            return next_char
            -- a = = -> a ==
          elseif prev_2char:match("^[=<>+%-*/%%!]") then
            return "<bs><bs>=" .. next_char
            -- a= -> a =
          elseif prev_2char:match("%S$") then
            return "<bs> =" .. next_char
          else
            return ""
          end
        end
      )
  -- 设置结尾字符长度为0，即光标总是在最后
      :set_end_pair_length(0)
  -- 光标不要右移。右移指 (|) 输入 ) 时,光标右移 -> ()|
      :with_move(cond.none())
      :with_del(cond.none()),
  -- javascript =>
  Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
      :use_regex(true)
      :set_end_pair_length(2),

  -- 条件中<自动补空格
  Rule("<", "")
      :with_pair(cond.not_inside_quote())
      :with_pair(function(opts)
        if opts.line:match("if") == "if" then
          return true
        elseif opts.line:match("for") == "for" then
          return true
        elseif opts.line:match("while") == "while" then
          return true
        elseif opts.line:match("cout") == "cout" then
          return true
        elseif opts.line:match("cerr") == "cerr" then
          return true
        elseif opts.line:match("<<") == "<<" then
          return true
        else
          return false
        end
      end)
      :replace_endpair(function(opts)
        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        local next_char = opts.line:sub(opts.col, opts.col)
        next_char = next_char == " " and "" or " "
        if prev_2char:match("%<$") then
          return next_char
        end
        if prev_2char:match("%S$") then
          return "<bs> <" .. next_char
        end
        if prev_2char:match("<") then
          return "<bs><bs><" .. next_char
        end
        return ""
      end)
      :set_end_pair_length(0)
      :with_move(cond.none())
      :with_del(cond.none()),
  Rule(">", "")
      :with_pair(cond.not_inside_quote())
      :with_pair(function(opts)
        if opts.line:match("if") == "if" then
          return true
        elseif opts.line:match("for") == "for" then
          return true
        elseif opts.line:match("while") == "while" then
          return true
        elseif opts.line:match("cin") == "cin" then
          return true
        elseif opts.line:match(">>") == ">>" then
          return true
        else
          return false
        end
      end)
      :replace_endpair(function(opts)
        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        local next_char = opts.line:sub(opts.col, opts.col)
        next_char = next_char == " " and "" or " "
        if prev_2char:match("%>$") then
          return next_char
        end
        if prev_2char:match("%S$") then
          return "<bs> >" .. next_char
        end
        if prev_2char:match(">") then
          return "<bs><bs>>" .. next_char
        end
        return ""
      end)
      :set_end_pair_length(0)
      :with_move(cond.none())
      :with_del(cond.none()),
})

-- 自动括回(可以括回多个)
-- local get_closing_for_line = function(line)
-- 	local i = -1
-- 	local clo = ""
--
-- 	while true do
-- 		i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
-- 		if i == nil then
-- 			break
-- 		end
-- 		local ch = string.sub(line, i, i)
-- 		local st = string.sub(clo, 1, 1)
--
-- 		if ch == "{" then
-- 			clo = "}" .. clo
-- 		elseif ch == "}" then
-- 			if st ~= "}" then
-- 				return ""
-- 			end
-- 			clo = string.sub(clo, 2)
-- 		elseif ch == "(" then
-- 			clo = ")" .. clo
-- 		elseif ch == ")" then
-- 			if st ~= ")" then
-- 				return ""
-- 			end
-- 			clo = string.sub(clo, 2)
-- 		elseif ch == "[" then
-- 			clo = "]" .. clo
-- 		elseif ch == "]" then
-- 			if st ~= "]" then
-- 				return ""
-- 			end
-- 			clo = string.sub(clo, 2)
-- 		end
-- 	end
--
-- 	return clo
-- end
--
-- -- autopairs.remove_rule("(")
-- -- autopairs.remove_rule("{")
-- -- autopairs.remove_rule("[")
--
-- autopairs.add_rule(Rule("[%(%{%[]", "")
-- 	:use_regex(true)
-- 	:replace_endpair(function(opts)
-- 		return get_closing_for_line(opts.line)
-- 	end)
-- 	:end_wise(function(opts)
-- 		-- Do not endwise if there is no closing
-- 		return get_closing_for_line(opts.line) ~= ""
-- 	end))
--
-- 括号间空格 (|) -> 按空格 -> ( | )
local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
autopairs.add_rules({
  Rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({
      brackets[1][1] .. brackets[1][2],
      brackets[2][1] .. brackets[2][2],
      brackets[3][1] .. brackets[3][2],
    }, pair)
  end),
})
for _, bracket in pairs(brackets) do
  autopairs.add_rules({
    Rule(bracket[1] .. " ", " " .. bracket[2])
        :with_pair(function()
          return false
        end)
        :with_move(function(opts)
          return opts.prev_char:match(".%" .. bracket[2]) ~= nil
        end)
        :use_key(bracket[2]),
  })
end

-- 未知
-- for _, punct in pairs({ ",", ";" }) do
-- 	require("nvim-autopairs").add_rules({
-- 		require("nvim-autopairs.rule")("", punct)
-- 			:with_move(function(opts)
-- 				return opts.char == punct
-- 			end)
-- 			:with_pair(function()
-- 				return false
-- 			end)
-- 			:with_del(function()
-- 				return false
-- 			end)
-- 			:with_cr(function()
-- 				return false
-- 			end)
-- 			:use_key(punct),
-- 	})
-- end

-- 智能结束,then后按回车，自动补end.
-- Rule('then', 'end'):end_wise(function(opts))
--     -- Add any context checks here, e.g. line starts with "if"
--     return string.match(opts.line, '^%s*if') ~= nil
-- end)

-- autopairs.add_rule(Rule("/* ", " */", { "-markdown" })) -- 除markdown以外都适用

-- you can use some built-in conditions

-- print(vim.inspect(cond))

-- autopairs.add_rules(
-- 	{
-- 		Rule("$", "$", { "tex", "latex" })
-- 			-- don't add a pair if the next character is %
-- 			:with_pair(cond.not_after_regex("%%"))
-- 			-- don't add a pair if  the previous character is xxx
-- 			:with_pair(cond.not_before_regex("xxx", 3))
-- 			-- don't move right when repeat character
-- 			:with_move(cond.none())
-- 			-- don't delete if the next character is xx
-- 			:with_del(cond.not_after_regex("xx"))
-- 			-- disable adding a newline when you press <cr>
-- 			:with_cr(cond.none()),
-- 	},
-- 	-- disable for .vim files, but it work for another filetypes
-- 	Rule("a", "a", "-vim")
-- )

-- autopairs.add_rules({
-- 	Rule("<", ">"):with_pair(function(opts)
-- print(vim.inspect(opts))
-- 		if opts.line == "#" then
-- 			-- don't add pair on that line
-- 			return true
-- 		else
-- 			return false
-- 		end
-- 	end),
-- })

-- -- you can use regex
-- -- press u1234 => u1234number
-- autopairs.add_rules({
-- 	Rule("u%d%d%d%d$", "number", "lua"):use_regex(true),
-- })

-- -- press x1234 => x12341234
-- autopairs.add_rules({
-- 	Rule("x%d%d%d%d$", "number", "lua"):use_regex(true):replace_endpair(function(opts)
-- 		-- print(vim.inspect(opts))
-- 		return opts.prev_char:sub(#opts.prev_char - 3, #opts.prev_char)
-- 	end),
-- })

-- -- you can do anything with regex +special key
-- -- example press tab to uppercase text:
-- -- press b1234s<tab> => B1234S1234S

-- autopairs.add_rules({
-- 	Rule("b%d%d%d%d%w$", "", "vim"):use_regex(true, "<tab>"):replace_endpair(function(opts)
-- 		return opts.prev_char:sub(#opts.prev_char - 4, #opts.prev_char) .. "<esc>viwU"
-- 	end),
-- })

-- -- you can exclude filetypes
-- autopairs.add_rule(Rule("$$", "$$"):with_pair(cond.not_filetypes({ "lua" })))
-- --- check ./lua/nvim-autopairs/rules/basic.lua

local ts_conds = require("nvim-autopairs.ts-conds")

-- press % => %% only while inside a comment or string
-- autopairs.add_rules({
-- 	Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
-- 	Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
-- })
-- end
