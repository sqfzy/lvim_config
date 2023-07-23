lvim.plugins = {
	{
		"mg979/vim-visual-multi",
		event = "BufRead",
		-- config = function()
		--   require("keymappings").set_multi_keymaps()
		-- end
	}, -- 多光标
	{
		"ggandor/leap.nvim",
		name = "leap",
		config = function()
			require("sqfzy.plugins_config.leap")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin" },
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("sqfzy.plugins_config.copilot")
		end,
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("sqfzy.plugins_config.zen-mode")
		end,
		cmd = "ZenMode",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		-- config = function()
		-- 	require("plugins_config.noice")
		-- end,
		config = require("sqfzy.plugins_config.noice").config(),
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("sqfzy.plugins_config.lspsaga")
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{ "simrat39/rust-tools.nvim", config = require("sqfzy.plugins_config.rust_tools").config() },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("sqfzy.plugins_config.crates")
		end,
	},
}
lvim.builtin.cmp.cmdline.enable = true
