-- In lvim, core plugins autopairs, cmp had been changed

require("sqfzy.lsp.lsp_config")
require("sqfzy.colorscheme")
require("sqfzy.options")
require("sqfzy.plugins")
require("sqfzy.functions")
local keymappings = require("sqfzy.keymappings")
keymappings.set_multi_keymaps()
keymappings.set_lunsnip_keymaps()

require("sqfzy.lsp.null-ls")

local luasnip = require("luasnip")

require("sqfzy.plugins_config.autopairs")
require("sqfzy.plugins_config.cmp")

-- 启用历史记录
luasnip.config.set_config({
	history = true,
})

--------------------- LSP  ---------------------
-- {
--   "lua_ls",
--   "alex",
--   "bash-language-server",
--   "black",
--   "clang-format",
--   "clangd",
--   "css-lsp",
--   "cssmodules-language-server",
--   "eslint_d",
--   "flake8",
--   "html-lsp",
--   "intelephense",
--   "json-lsp",
--   "lua-language-server",
--   "phpcbf",
--   "phpstan",
--   "prettier",
--   "pyright",
--   "stylua",
--   "tailwindcss-language-server",
--   "typescript-language-server",
--   "vim-language-server",
-- }
