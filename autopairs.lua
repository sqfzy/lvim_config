local M = {}

function M.config()
  lvim.builtin.autopairs = {
    active = true,
    on_config_done = nil,
    ---@usage  modifies the function or method delimiter by filetypes
    map_char = {
      all = "(",
      tex = "{",
    },
    ---@usage check bracket in same line
    enable_check_bracket_line = false,
    ---@usage check treesitter
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
    enable_moveright = true,
    ---@usage disable when recording or executing a macro
    disable_in_macro = false,
    ---@usage add bracket pairs after quote
    enable_afterquote = true,
    ---@usage map the <BS> key
    map_bs = true,
    ---@usage map <c-w> to delete a pair if possible
    map_c_w = false,
    ---@usage disable when insert after visual block mode
    disable_in_visualblock = false,
    ---@usage  change default fast_wrap
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  }
end

M.setup = function()
  local status_ok, autopairs = pcall(require, "nvim-autopairs")
  if not status_ok then
    return
  end

  autopairs.setup {
    check_ts = lvim.builtin.autopairs.check_ts,
    enable_check_bracket_line = lvim.builtin.autopairs.enable_check_bracket_line,
    ts_config = lvim.builtin.autopairs.ts_config,
    disable_filetype = lvim.builtin.autopairs.disable_filetype,
    disable_in_macro = lvim.builtin.autopairs.disable_in_macro,
    ignored_next_char = lvim.builtin.autopairs.ignored_next_char,
    enable_moveright = lvim.builtin.autopairs.enable_moveright,
    enable_afterquote = lvim.builtin.autopairs.enable_afterquote,
    map_c_w = lvim.builtin.autopairs.map_c_w,
    map_bs = lvim.builtin.autopairs.map_bs,
    disable_in_visualblock = lvim.builtin.autopairs.disable_in_visualblock,
    fast_wrap = lvim.builtin.autopairs.fast_wrap,
  }

  if lvim.builtin.autopairs.on_config_done then
    lvim.builtin.autopairs.on_config_done(autopairs)
  end

  pcall(function()
    local function on_confirm_done(...)
      require("nvim-autopairs.completion.cmp").on_confirm_done()(...)
    end
    require("cmp").event:off("confirm_done", on_confirm_done)
    require("cmp").event:on("confirm_done", on_confirm_done)
  end)

  local Rule = require "nvim-autopairs.rule"
  local cond = require "nvim-autopairs.conds"
  autopairs.add_rules {
    -- 注释
    Rule("/* ", " */", { "c", "cpp", "css", "javascript", "php", "rust" }):with_pair(cond.not_inside_quote()),
    Rule("//", " ", { "c", "cpp", "javascript", "php", "rust" })
        :with_pair(cond.not_inside_quote())
        :replace_endpair(function(opts)
          local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
          if prev_2char:match "^/" then
            return "<bs><bs>// "
          elseif prev_2char:match "^%S" then
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
          elseif prev_2char:match "#" then
            return ""
          elseif prev_2char:match "%S%s" then
            return "<bs> # "
          elseif prev_2char:match "%S$" then
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
        :replace_endpair(function(opts)
          local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
          local flag = false
          local line = opts.line
          if line:match "if" or line:match "while" then
            flag = true
          end
          if flag and prev_2char:match "[<>]$" then
            return " "
          elseif flag and prev_2char:match "^[<>]" then
            return "<bs><bs>= "
            -- a == -> a ==
          elseif prev_2char:match "[=+%-*/%%!]$" then
            return " "
            -- a = = -> a ==
          elseif prev_2char:match "^[=+%-*/%%!]" then
            return "<bs><bs>=" .. " "
            -- a= -> a =
          elseif prev_2char:match "%S$" then
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
    Rule("<", "")
        :with_pair(cond.not_inside_quote())
        :with_pair(function(opts)
          if opts.line:match "if" == "if" then
            return true
          elseif opts.line:match "for" == "for" then
            return true
          elseif opts.line:match "while" == "while" then
            return true
          elseif opts.line:match "cout" == "cout" then
            return true
          elseif opts.line:match "cerr" == "cerr" then
            return true
          elseif opts.line:match "<<" == "<<" then
            return true
          else
            return false
          end
        end)
        :replace_endpair(function(opts)
          local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
          -- local next_char = opts.line:sub(opts.col, opts.col)
          -- next_char = next_char == " " and "" or " "
          if prev_2char:match "%<$" then
            return " "
          end
          if prev_2char:match "%S$" then
            return "<bs> <" .. " "
          end
          if prev_2char:match "<" then
            return "<bs><bs><" .. " "
          end
          return " "
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none()),
    Rule(">", "")
        :with_pair(cond.not_inside_quote())
        :with_pair(function(opts)
          if opts.line:match "if" == "if" then
            return true
          elseif opts.line:match "for" == "for" then
            return true
          elseif opts.line:match "while" == "while" then
            return true
          elseif opts.line:match "cin" == "cin" then
            return true
          elseif opts.line:match ">>" == ">>" then
            return true
          else
            return false
          end
        end)
        :replace_endpair(function(opts)
          local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
          if prev_2char:match "%>$" then
            return " "
          end
          if prev_2char:match "%S$" then
            return "<bs> >" .. " "
          end
          if prev_2char:match ">" then
            return "<bs><bs>>" .. " "
          end
          return " "
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none()),
  }
end

return M
