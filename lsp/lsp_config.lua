local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

lvim.lsp.automatic_servers_installation = false
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "intelephense" })

vim.diagnostic.config({
	virtual_text = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities() -- 提供基本功能
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.default_capabilities(capabilities) -- 提供cmp功能

local on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false -- 禁用格式化
	end

	if client.name == "clangd" then
		client.server_capabilities.offsetEncoding = { "utf-16" }
	end

	-- -- 单词突显
	-- illuminate.on_attach(client)
end

lspconfig.intelephense.setup({
	opts = {
		cmd = { "intelephense", "--stdio" },
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "php" },
		init_options = {
			licenceKey = "KALI",
			storagePath = "/tmp/intelephense",
			clearCache = true,
			files = {
				maxSize = 1000000,
			},
		},
	},
	root_dir = function(fname)
		local util = require("lspconfig/util")
		return util.root_pattern("/home/kali/", vim.fn.getcwd())(fname)
	end,
})
