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
		filetypes = { "javascript", "html", "css" },
		extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
	},
	{ name = "stylua" },
	{
		name = "clang_format",
		filetypes = { "c", "cpp" },
		args = { "--style=Google" },
	},
	{ name = "phpcbf" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		name = "flake8",
		filetypes = { "python" },
		extra_args = { "--ignore=E501" },
		-- extra_args = { "--max-line-length=120" },
	},
	{
		name = "shellcheck",
		args = { "--severity", "warning" },
	},
	{ name = "phpstan" },
	{ name = "eslint_d" },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		name = "proselint",
	},
})
