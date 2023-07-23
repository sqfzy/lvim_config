lvim.builtin.autopairs.on_config_done = function(autopairs)
	local Rule = require("nvim-autopairs.rule")
	local cond = require("nvim-autopairs.conds")
	autopairs.add_rules({
		-- 注释
		Rule("/* ", " */", { "c", "cpp", "css", "javascript", "php", "rust" }):with_pair(cond.not_inside_quote()),
		Rule("//", " ", { "c", "cpp", "javascript", "php", "rust" })
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
		Rule("// /", "", { "rust" })
			:with_pair(cond.not_inside_quote)
			:replace_endpair(function()
				return "<bs><bs>/ "
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
		Rule("<>", "", { "rust", "cpp", "c", "html", "lua" }):with_pair(cond.none):set_end_pair_length(1),
		Rule("||", "", { "rust" }):with_pair(cond.none):set_end_pair_length(1),
		-- \t  \n
		Rule("\\t", "", { "c", "cpp", "php", "python" })
			:with_pair(cond.not_inside_quote())
			:replace_endpair(function()
				return "<bs><bs>'\\t'"
			end)
			:set_end_pair_length(0),
		Rule("\\n", "", { "c", "cpp", "php", "python" })
			:with_pair(cond.not_inside_quote())
			:replace_endpair(function()
				return "<bs><bs>'\\n'"
			end)
			:set_end_pair_length(0),

		-- 等号自动补空格
		Rule("=", "", { "-html", "-rust" })
			:with_pair(cond.not_inside_quote())
			:replace_endpair(function(opts)
				local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
				local flag = false
				local line = opts.line
				if line:match("if") or line:match("while") then
					flag = true
        elseif prev_2char:match("[<>]") then
          flag = true
				end
				if flag and prev_2char:match("[<>]$") then
					return " "
				elseif flag and prev_2char:match("^[<>]") then
					return "<bs><bs>= "
				-- a == -> a ==
				elseif prev_2char:match("[=+%-*/%%!]$") then
					return " "
				-- a = = -> a ==
				elseif prev_2char:match("^[=+%-*/%%!]") then
					return "<bs><bs>=" .. " "
				-- a= -> a =
				elseif prev_2char:match("%S$") then
					return "<bs> =" .. " "
				else
					return " "
				end
			end)
			-- 设置结尾字符长度为0，即光标总是在最后
			:set_end_pair_length(0)
			-- 光标不要右移。右移指 (|) 输入 ) 时,光标右移 -> ()|
			:with_move(cond.none())
			:with_del(cond.none()),
		-- javascript =>
		Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript", "rust" })
			:use_regex(true)
			:set_end_pair_length(2),

		-- 条件中<自动补空格
		Rule("<", "", { "-rust" })
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
				-- local next_char = opts.line:sub(opts.col, opts.col)
				-- next_char = next_char == " " and "" or " "
				if prev_2char:match("%<$") then
					return " "
				end
				if prev_2char:match("%S$") then
					return "<bs> <" .. " "
				end
				if prev_2char:match("<") then
					return "<bs><bs><" .. " "
				end
				return " "
			end)
			:set_end_pair_length(0)
			:with_move(cond.none())
			:with_del(cond.none()),
		Rule(">", "", { "-rust" })
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
				if prev_2char:match("%>$") then
					return " "
				end
				if prev_2char:match("%S$") then
					return "<bs> >" .. " "
				end
				if prev_2char:match(">") then
					return "<bs><bs>>" .. " "
				end
				return " "
			end)
			:set_end_pair_length(0)
			:with_move(cond.none())
			:with_del(cond.none()),
		Rule("=", "", { "rust" })
			:with_pair(cond.not_inside_quote())
			:replace_endpair(function(opts)
				local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
				local flag = false
				local line = opts.line
				if line:match(" if ") or line:match(" while ") then
					flag = true
				end
				if prev_2char == ".." or prev_2char == ">>" or prev_2char == "<<" then
					return ""
				elseif prev_2char == ". " then
					return "<bs><bs>="
				elseif flag and prev_2char:match("[<>]$") then
					return " "
				elseif flag and prev_2char:match("^[<>]") then
					return "<bs><bs>= "
				-- a == -> a ==
				elseif prev_2char:match("[=+%-*/%%!]$") then
					return " "
				-- a = = -> a ==
				elseif prev_2char:match("^[=+%-*/%%!]") then
					return "<bs><bs>=" .. " "
				-- a= -> a =
				elseif prev_2char:match("%S$") then
					return "<bs> =" .. " "
				else
					return " "
				end
			end)
			-- 设置结尾字符长度为0，即光标总是在最后
			:set_end_pair_length(0)
			-- 光标不要右移。右移指 (|) 输入 ) 时,光标右移 -> ()|
			:with_move(cond.none())
			:with_del(cond.none()),
		Rule("<", "", { "rust" })
			:with_pair(cond.not_inside_quote())
			:with_pair(function(opts)
				if opts.line:match(" if ") then
					return true
				elseif opts.line:match(" while ") then
					return true
				else
					return false
				end
			end)
			:replace_endpair(function(opts)
				local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
				-- local next_char = opts.line:sub(opts.col, opts.col)
				-- next_char = next_char == " " and "" or " "
				if prev_2char:match("%<$") then
					return " "
				end
				if prev_2char:match("%S$") then
					return "<bs> <" .. " "
				end
				if prev_2char:match("<") then
					return "<bs><bs><" .. " "
				end
				return " "
			end)
			:set_end_pair_length(0)
			:with_move(cond.none())
			:with_del(cond.none()),
		Rule(">", "", { "rust" })
			:with_pair(cond.not_inside_quote())
			:with_pair(function(opts)
				if opts.line:match(" if ") then
					return true
				elseif opts.line:match(" while ") == "while" then
					return true
				else
					return false
				end
			end)
			:replace_endpair(function(opts)
				local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
				if prev_2char:match("%>$") then
					return " "
				end
				if prev_2char:match("%S$") then
					return "<bs> >" .. " "
				end
				if prev_2char:match(">") then
					return "<bs><bs>>" .. " "
				end
				return " "
			end)
			:set_end_pair_length(0)
			:with_move(cond.none())
			:with_del(cond.none()),
	})
end
