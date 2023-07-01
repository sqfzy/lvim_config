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
      require("plugins_config.leap")
    end,
  },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("plugins_config.copilot")
    end,
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("plugins_config.zen-mode")
    end,
    cmd = "ZenMode",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins_config.noice")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require("plugins_config.outline")
    end,
  },
}
lvim.builtin.cmp.cmdline.enable = true
-- return {

-- 	--------------------------------------------------------------------
-- 	------------------------------ 包管理器 ----------------------------------
-- 	--------------------------------------------------------------------
-- 	{ "folke/lazy.nvim" },
-- 	-- { "wbthomason/packer.nvim" },
-- 	-------------------------------------------------------------------- ----------------------------- LSP ----------------------------------
-- 	--------------------------------------------------------------------
-- 	{ "neovim/nvim-lspconfig" }, -- 方便设置LSP服务默认设置
-- 	{ "williamboman/mason.nvim" },
-- 	{ "williamboman/mason-lspconfig.nvim" }, -- 让mason和nvim-lspconfig更兼容
-- 	{ "jose-elias-alvarez/null-ls.nvim" }, -- 专门的linter和format等
-- 	-- { "folke/trouble.nvim" }, -- 调试
-- 	{
-- 		"glepnir/lspsaga.nvim",
-- 		config = function()
-- 			require("plugin-config.lspsaga")
-- 		end,
-- 		event = "LspAttach",
-- 	},
-- 	{ "nanotee/sqls.nvim", ft = "sql" }, -- sql
-- 	{
-- 		"RRethy/vim-illuminate",
-- 		event = "LspAttach",
-- 		config = function()
-- 			require("plugin-config.illuminate")
-- 		end,
-- 	}, -- 突显光标下的单词(透明)
-- 	--------------------------------------------------------------------
-- 	------------------------------ 补全 ----------------------------------
-- 	--------------------------------------------------------------------
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		event = "InsertEnter",
-- 		config = function()
-- 			require("plugin-config.cmp")
-- 		end,
-- 	},
-- 	{ "hrsh7th/cmp-buffer", event = "InsertEnter" }, -- 根据缓冲区的单词进行补全
-- 	{ "hrsh7th/cmp-path", event = "InsertEnter" }, -- 补全路径
-- 	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" }, -- luasnip补全
-- 	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" }, -- lsp补全
-- 	{ "hrsh7th/cmp-nvim-lua", event = "InsertEnter" }, -- nvim的lua的api
-- 	{ "hrsh7th/cmp-calc", event = "InsertEnter" }, -- 计算
-- 	{ "hrsh7th/cmp-cmdline", event = "CmdlineEnter" }, -- nvim的命令
-- 	{ "ray-x/cmp-treesitter", event = "InsertEnter" }, -- 根据treesitter补全
-- 	{ "jcha0713/cmp-tw2css", ft = "css" }, -- 在css中根据tailwindcss的类名进行补全
-- 	-- {
-- 	-- 	"tzachar/cmp-tabnine",
-- 	-- 	build = "./install.sh",
-- 	-- 	dependencies = "hrsh7th/nvim-cmp",
-- 	-- }, -- 根据语境更好地提供补全
-- 	-- 自动补全
-- 	-- { "tzachar/cmp-tabnine", build = "./install.sh", dependencies = "hrsh7th/nvim-cmp" },
-- 	-- {
-- 	--   "zbirenbaum/copilot-cmp",
-- 	--   after = { "copilot.lua" },
-- 	--   config = function ()
-- 	--     require("copilot_cmp").setup()
-- 	--   end
-- 	-- }
-- 	--------------------------------------------------------------------
-- 	---------------------------- snippets ------------------------------
-- 	--------------------------------------------------------------------
-- 	{
-- 		"L3MON4D3/LuaSnip",
-- 		config = function()
-- 			require("plugin-config.luasnip")
-- 			require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/luasnippets" }) -- 自定义luasnip片段
-- 			require("luasnip.loaders.from_lua").lazy_load()
-- 			require("luasnip.loaders.from_vscode").lazy_load()
-- 			require("luasnip.loaders.from_snipmate").lazy_load()
-- 		end,
-- 		-- follow latest release.
-- 		-- version = "<CurrentMajor>.*",
-- 		-- install jsregexp (optional!).
-- 		-- build = "make install_jsregexp",
-- 		event = "InsertEnter",
-- 	}, --snippet engine
-- 	{ "rafamadriz/friendly-snippets", lazy = false }, -- a bunch of snippets to
-- 	--
-- 	--------------------------------------------------------------------
-- 	-------------------------- treesitter --------------------------
-- 	--------------------------------------------------------------------
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		event = "BufRead",
-- 		config = function()
-- 			require("plugin-config.nvim-treesitter")
-- 		end,
-- 		build = ":TSUpdate",
-- 		-- priority = 1000,
-- 		dependencies = {
-- 			"JoosepAlviste/nvim-ts-context-commentstring",
-- 			"mrjones2014/nvim-ts-rainbow", -- 插件：彩虹括号
-- 			"JoosepAlviste/nvim-ts-context-commentstring", -- 插件：代码注释
-- 		},
-- 	}, -- 代码高亮
-- 	-- {
-- 	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
-- 	-- 	after = "nvim-treesitter",
-- 	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
-- 	-- },
-- 	--
-- 	--------------------------------------------------------------------
-- 	------------------------------ UI -----------------------------------
-- 	--------------------------------------------------------------------
-- 	{
-- 		"projekt0n/github-nvim-theme",
-- 		version = "v0.0.7",
-- 		-- or                            branch = '0.0.x'
-- 		config = function()
-- 			require("github-theme").setup()
-- 		end,
-- 	},
-- 	{ "catppuccin/nvim", name = "catppuccin" },
-- 	{ "folke/tokyonight.nvim" }, -- tokyonight主题
-- 	{
-- 		"kyazdani42/nvim-tree.lua",
-- 		dependencies = "kyazdani42/nvim-web-devicons",
-- 		cmd = "NvimTreeToggle",
-- 		config = function()
-- 			require("plugin-config.nvim-tree")
-- 		end,
-- 	}, -- 文件树
-- 	{
-- 		"akinsho/bufferline.nvim",
-- 		-- dependencies = "moll/vim-bbye",
-- 	}, -- 标签页
-- 	{
-- 		"famiu/bufdelete.nvim",
-- 		event = "BufRead",
-- 	}, -- buffer删除
-- 	{
-- 		"nvim-lualine/lualine.nvim",
-- 		dependencies = { "arkav/lualine-lsp-progress" },
-- 	}, -- 状态栏
-- 	-- { "SmiteshP/nvim-navic" }, -- 标签页的变量导航
-- 	{ "goolord/alpha-nvim" }, -- 启动页驱动

-- 	--------------------------------------------------------------------
-- 	------------------------ telescope模糊搜索文件 ------------------------
-- 	--------------------------------------------------------------------
-- 	{
-- 		"nvim-telescope/telescope.nvim",
-- 		cmd = "Telescope",
-- 		config = function()
-- 			require("plugin-config.telescope")
-- 		end,
-- 		dependencies = {
-- 			"nvim-lua/plenary.nvim",
-- 			"LinArcX/telescope-env.nvim", -- 插件：查看环境变量
-- 			-- "ahmedkhalf/project.nvim", -- 插件：搜索项目
-- 			{
-- 				"benfowler/telescope-luasnip.nvim",
-- 				module = "telescope._extensions.luasnip", -- if you wish to lazy-load
-- 			},
-- 			"BurntSushi/ripgrep", -- 查看寄存器
-- 		},
-- 	},
-- 	-- { "nvim-lua/plenary.nvim" },

-- 	--------------------------------------------------------------------
-- 	--------------------------- 功能 -----------------------------------
-- 	--------------------------------------------------------------------
-- 	{
-- 		"mg979/vim-visual-multi",
-- 		event = "BufRead",
-- 	}, -- 多光标
-- 	{
-- 		"folke/which-key.nvim",
-- 	}, -- 显示快捷键
-- 	{ "Tastyep/structlog.nvim", enabled = false }, -- 日志
-- 	{ "folke/neodev.nvim" }, -- nvim的详细API
-- 	{
-- 		"windwp/nvim-autopairs",
-- 		event = "InsertEnter",
-- 		config = function()
-- 			require("plugin-config.autopairs")
-- 		end,
-- 	}, -- 自动配对
-- 	{
-- 		"numToStr/Comment.nvim",
-- 		config = function()
-- 			require("plugin-config.comment")
-- 		end,
-- 		event = "BufRead",
-- 	}, -- 代码注释
-- 	-- {
-- 	-- 	"akinsho/toggleterm.nvim",
-- 	-- }, -- 终端
-- 	-- {
-- 	-- 	"folke/twilight.nvim",
-- 	-- 	enabled = false,
-- 	-- 	-- config = require("plugin-config.twilight").setup(),
-- 	-- }, -- 非聚焦的代码变暗
-- 	{
-- 		"folke/zen-mode.nvim",
-- 		config = function()
-- 			require("plugin-config.zen-mode")
-- 		end,
-- 		cmd = "ZenMode",
-- 	},
-- 	{
-- 		"lukas-reineke/indent-blankline.nvim",
-- 		config = function()
-- 			require("plugin-config.indentlines")
-- 		end,
-- 		event = "BufRead",
-- 	},
-- 	-- { "github/copilot.vim" },
-- 	{
-- 		"zbirenbaum/copilot.lua",
-- 		config = function()
-- 			require("plugin-config.copilot")
-- 		end,
-- 		cmd = "Copilot",
-- 		event = "InsertEnter",
-- 	},
-- 	-- { "mfussenegger/nvim-dap" }, -- 调试
-- 	-- { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },
-- 	{
-- 		"ggandor/leap.nvim",
-- 		config = function()
-- 			require("plugin-config.leap")
-- 		end,
-- 		event = "BufRead",
-- 	},
-- 	-- { "tpope/vim-repeat" },
-- 	-- {
-- 	-- 	"glacambre/firenvim",

-- 	-- 	-- Lazy load firenvim
-- 	-- 	-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
-- 	-- 	cond = not not vim.g.started_by_firenvim,
-- 	-- 	build = function()
-- 	-- 		require("lazy").load({ plugins = "firenvim", wait = true })
-- 	-- 		vim.fn["firenvim#install"](0)
-- 	-- 	end,
-- 	-- }, -- 浏览器上用neovim
-- 	{ "lambdalisue/suda.vim" },
-- }
