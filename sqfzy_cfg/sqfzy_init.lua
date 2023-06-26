-- In lvim, core plugins autopairs, cmp had been changed

require("colorscheme")
require("options")
require("plugins")
require("functions")
local keymappings = require("keymappings")
keymappings.set_multi_keymaps()
keymappings.set_lunsnip_keymaps()

require("lsp.null-ls")

local luasnip = require("luasnip")

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
