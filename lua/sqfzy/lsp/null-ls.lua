local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    name = "black",
    filetypes = { "python" },
    extra_args = { "--line-length=80" },
  },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    -- filetypes = { "typescript", "typescriptreact" },
    -- extra_filetypes = { "javascript" },
    filetypes = { "html", "css" },
    extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
  },
  { name = "stylua" },
  {
    name = "clang_format",
    filetypes = { "c", "cpp" },
    args = { "--style=Google" },
  },
  { name = "phpcbf" },
  { name = "rustfmt" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    name = "flake8",
    filetypes = { "python" },
    extra_args = { "--ignore=E501" },
    -- extra_args = { "--max-line-length=120" },
  },
  -- {
  -- 	name = "shellcheck",
  -- 	args = { "--severity", "warning" },
  -- },
  { name = "phpstan" },
  { name = "eslint_d" },
  -- { name = "cpplint" },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
  {
    name = "proselint",
  },
})

-- local lsp_formatting = function(bufnr)
-- 	vim.lsp.buf.format({
-- 		filter = function(client)
-- 			-- apply whatever logic you want (in this example, we'll only use null-ls)
-- 			return client.name == "null-ls"
-- 		end,
-- 		bufnr = bufnr,
-- 	})
-- end

-- -- if you want to set up formatting on save, you can use this as a callback
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- -- add to your shared on_attach callback
-- local on_attach = function(client, bufnr)
-- 	if client.supports_method("textDocument/formatting") then
-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			group = augroup,
-- 			buffer = bufnr,
-- 			callback = function()
-- 				lsp_formatting(bufnr)
-- 			end,
-- 		})
-- 	end
-- end
