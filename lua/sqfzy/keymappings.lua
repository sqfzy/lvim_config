local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-------------------------------  normal ---------------------------------------------
lvim.keys.normal_mode = {
	-- Better window movement
	["<C-h>"] = "<C-w>h",
	["<C-j>"] = "<C-w>j",
	["<C-k>"] = "<C-w>k",
	["<C-l>"] = "<C-w>l",
	-- ["<C-w>"] = "<C-w>w",

	-- Resize with arrows
	["<C-Up>"] = ":resize -2<CR>",
	["<C-Down>"] = ":resize +2<CR>",
	["<C-Left>"] = ":vertical resize -2<CR>",
	["<C-Right>"] = ":vertical resize +2<CR>",

	-- Move current line / block with Alt-j/k a la vscode.
	["<A-j>"] = ":m .+1<CR>==",
	["<A-k>"] = ":m .-2<CR>==",

	-- QuickFix
	["]q"] = ":cnext<CR>",
	["[q"] = ":cprev<CR>",
	["<C-q>"] = ":call QuickFixToggle()<CR>",

	["<Esc>"] = "",
	["L"] = "$",
	["H"] = "^",
	["c"] = '"dc',
	["s"] = '"ds',
	["<C-d>"] = "10j",
	["<C-u>"] = "10k",
	["<C-a>"] = "gg^vG$",
	["<A-a>"] = "<C-a>", --值加1
	["<A-d>"] = "<C-x>", --值减1
	-- ["<C-n>"] = "&", --重复替换操作
	["yw"] = "byw", -- 复制单词
	["ty"] = '"ty',
	["yib"] = "yi(",
	["yis"] = 'yi"',
	["yii"] = "yi{",
	["tp"] = '"tp',
	["X"] = "dd", --剪切一行
	-- ["<C-x>"] = '"+dw', --剪切单词
	["d"] = '"_d', --删除
	["D"] = '"_D',
	["dL"] = '"_d$',
	["dH"] = '"_d^',
	["E"] = "ea<Space>",
	["B"] = "bi<Space><Left>",
	["mj"] = "mJ",
	["mk"] = "mK",
	["gj"] = "`J",
	["gk"] = "`K",
	-- 折叠
	["zh"] = "zfi{",
	["zl"] = "zo",
	-- 标签页
	["<A-l>"] = ":BufferLineCycleNext<CR>",
	["<A-h>"] = ":BufferLineCyclePrev<CR>",
	["<A-c>"] = "<cmd>BufferKill<cr>",
	["<A-o>"] = "<C-^>", -- 在两个最近的标签页间跳转
	["<A-v>"] = ":vs<CR>",
	["<A-x>"] = ":sp<CR>", --m == alt ()
	-- 添加，替换，搜索
	["<A-;>"] = "$a;<ESC>", --句尾添';'
	["<A-,>"] = "$a,<ESC>", --句尾添','
	["<A-s>"] = 'bi"<ESC>ea"<ESC>',
	["<A-i>"] = "bi{<ESC>ea}<ESC>",
	["<A-'>"] = "bi'<ESC>ea'<ESC>",
	["<A-b>"] = "bi(<ESC>ea)<ESC>",
	["<A-9>"] = "bi(<ESC>ea)<ESC>",
	["<A-[>"] = "bi[<ESC>ea]<ESC>",
	["cb"] = '"_cib', --()
	["ci"] = '"_ciB', --{}
	["cw"] = '"_ciw', --单词
	["cs"] = '"_ci"', --字符串
	["c'"] = "\"_ci'", -- ''
	["c["] = '"_ci[', -- []
	["c,"] = '"_ci<', -- <>
	["db"] = '"tyi(da(h"tp',
	["d9"] = '"tyi(da(h"tp',
	["ds"] = '"tyi"da"h"tp',
	["d["] = '"tyi[da[h"tp',
	["di"] = '"tyi{da{h"tp',
	["<BS>"] = 'mt%"_x`ta<BS><Space><Esc>',
	["<A-f>"] = "/<C-r>+<CR>", --搜寻复制内容
	[";"] = "n",
	[","] = "N",
	[">"] = ">>",
	["<"] = "<<",

	["<A-Down>"] = "O<Esc>",
	["<A-Up>"] = "o<Esc>",
}

-------------------------------  insert ---------------------------------------------
lvim.keys.insert_mode = {
	-- Move current line / block with Alt-j/k ala vscode.
	["<A-j>"] = "<Esc>:m .+1<CR>==gi",
	-- Move current line / block with Alt-j/k ala vscode.
	["<A-k>"] = "<Esc>:m .-2<CR>==gi",
	-- navigation
	["<A-Up>"] = "<C-\\><C-N><C-w>k",
	["<A-Down>"] = "<C-\\><C-N><C-w>j",
	["<A-Left>"] = "<C-\\><C-N><C-w>h",
	["<A-Right>"] = "<C-\\><C-N><C-w>l",

	["jj"] = "<ESC>",
	["jk"] = "<ESC>",
	["<A-;>"] = "<ESC>$a;", --句尾添';'
	["<A-s>"] = '<ESC>bi"<ESC>ea"',
	["<A-i>"] = "<ESC>bi{<ESC>ea}",
	["<A-9>"] = "<ESC>bi(<ESC>ea)",
	["<A-'>"] = "<ESC>bi'<ESC>ea'",
	["<A-[>"] = "<ESC>bi[<ESC>ea]",
	["<A-,>"] = "<ESC>bi<<ESC>ea>",
	["<A-->"] = "->",
	["<A-=>"] = "=>",
	-- ["<Tab>"] = "<Right>",
	-- ["<S-Tab>"] = "<Left>",
	["<S-Right>"] = "<Left>",

	-- ["<S-l><S-l>"] = "<Esc><S-a>",
	-- ["<S-h><S-h>"] = "<Esc><S-i>",

	["<C-h>"] = "<Esc>gh",
	["<C-l>"] = "<Esc>lgh",
}

-------------------------------  visual ---------------------------------------------
local visual_mode = {
	-- Better indenting
	["<"] = "<gv",
	[">"] = ">gv",
	["<A-j>"] = ":m '>+1<CR>gv-gv",
	["<A-k>"] = ":m '<-2<CR>gv-gv",

	["H"] = "^",
	["L"] = "$",
	["<C-a>"] = "<ESC>gg", --取消全选
	["<A-a>"] = "<C-a>",
	["ty"] = '"ty',
	["X"] = "D", --剪切一行
	["d"] = '"_d', --删除
	["D"] = '"_D',
	["p"] = '"_dP', -- 粘贴后不会复制被粘贴的文本
	["tp"] = '"_d"tP',
	["zh"] = "zf",
	["<A-s>"] = '"-xi""<Esc>"-P',
	["<A-i>"] = '"-xi{}<Esc>"-P',
	["<A-'>"] = "\"-xi''<Esc>\"-P",
	["<A-b>"] = '"-xi()<Esc>"-P',
	["<A-[>"] = '"-xi[]<Esc>"-P',
	["<A-,>"] = '"-xi<><Esc>"-P',
}
for k, v in pairs(visual_mode) do
	map("v", k, v, opts)
end

-------------------------------  visual-block ---------------------------------------------
lvim.keys.visual_block_mode = {
	-- Move current line / block with Alt-j/k ala vscode.
	["<A-j>"] = ":m '>+1<CR>gv-gv",
	["<A-k>"] = ":m '<-2<CR>gv-gv",
}

-- -------------------------------  term ---------------------------------------------
local term_mode = {
	-- Terminal window navigation
	["<C-h>"] = "<C-\\><C-N><C-w>h",
	["<C-j>"] = "<C-\\><C-N><C-w>j",
	["<C-k>"] = "<C-\\><C-N><C-w>k",
	["<C-l>"] = "<C-\\><C-N><C-w>l",
}
for k, v in pairs(term_mode) do
	map("t", k, v, opts)
end

-------------------------------  select ---------------------------------------------
local select_mode = {
	["p"] = "p",
	["d"] = "d",
	["D"] = "D",
	["<BS>"] = "<BS>i",
	["<C-l>"] = "<Right>",
	["<C-h>"] = "<Left>",
}
for k, v in pairs(select_mode) do
	map("s", k, v, opts)
end

---------------------------------------------------------------------
----------------------------- Plugins ----------------------------------
---------------------------------------------------------------------
local pluginKeys = {}

-------------------------------  lunsnip快捷键  ---------------------------------------------
pluginKeys.set_lunsnip_keymaps = function()
	--切换补全
	map("i", "<A-n>", "<Plug>luasnip-next-choice", opts)
	map("s", "<A-n>", "<Plug>luasnip-next-choice", opts)
	map("i", "<A-p>", "<Plug>luasnip-prev-choice", opts)
	map("s", "<A-p>", "<Plug>luasnip-prev-choice", opts)
	map("i", "<A-h>", "<cmd>lua require('luasnip').jump(-1)<Cr>", opts)
	map("s", "<A-h>", "<cmd>lua require('luasnip').jump(-1)<Cr>", opts)
	map("i", "<A-l>", "<cmd>lua require('luasnip').jump(1)<Cr>", opts)
	map("s", "<A-l>", "<cmd>lua require('luasnip').jump(1)<Cr>", opts)
end

-------------------------------  leap  ---------------------------------------------
pluginKeys.set_leap_keymaps = function()
	map("n", "f", "<Plug>(leap-forward-to)", opts)
	map("n", "F", "<Plug>(leap-backward-to)", opts)
	map("n", "s", "<Plug>(leap-forward-till)", opts)
	map("n", "S", "<Plug>(leap-backward-till)", opts)
	map("n", "<C-f>", "<Plug>(leap-from-window)", opts)
end

-------------------------------  vim-mul  ---------------------------------------------
vim.g.VM_default_mappings = 0
pluginKeys.set_multi_keymaps = function()
	vim.g.VM_maps = {}
	vim.g.VM_maps = {
		["Remove Region"] = "<C-p>",
		["Select All"] = "<C-A-n>",
	}
end

-------------------------------  cmp  ---------------------------------------------
lvim.builtin.cmp.confirm_opts.select = true
lvim.builtin.cmp.mapping["<Tab>"] = require("cmp").mapping.confirm({ select = true })

-------------------------------  lspsaga  ---------------------------------------------
pluginKeys.set_lspsaga_keymappings = function()
	local keymap = vim.keymap.set

	keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
	keymap("n", "gd", "<cmd>Lspsaga lsp_finder<CR>")
	keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>")
	keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>")
	keymap("n", "<leader>lR", "<cmd>Lspsaga rename ++project<CR>")
	keymap("n", "<leader>k", function()
		require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)
	keymap("n", "<leader>j", function()
		require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)
	keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
	keymap("n", "gi", "<cmd>Lspsaga incoming_calls<CR>")
	keymap("n", "go", "<cmd>Lspsaga outgoing_calls<CR>")
end

-------------------------------  which_key  ---------------------------------------------
local wk = lvim.builtin.which_key.mappings
wk["w"] = { "<cmd>lua vim.lsp.buf.format()<cr><cmd>w!<cr>", "Save with format" }
wk["W"] = { "<cmd>w!<cr>", "Save" }
wk["z"] = { "<cmd>ZenMode<CR>", "ZenMode" }
wk["c"] = {
	name = "Copilot",
	{
		e = { "<cmd>Copilot disable<CR>", "Copilot disable" },
		b = { "<cmd>Copilot enable<CR>", "Copilot enable" },
		E = { "<cmd>lua require('copilot.suggestion').dismiss()<cr>", "Copilot dismiss" },
	},
}
wk["S"] = {
	name = "Sqfzy",
	c = { "<cmd>edit $HOME/code_my/code_my.txt<cr>", "My code" },
	i = { "<cmd>edit $HOME/AppData/Local/lvim/lua/sqfzy/sqfzy_init.lua<cr>", "Edit init.lua" },
	k = { "<cmd>edit $HOME/AppData/Local/lvim/lua/sqfzy/keymappings.lua<cr>", "Edit keymappings.lua" },
	o = { "<cmd>edit $HOME/AppData/Local/lvim/lua/sqfzy/options.lua<cr>", "Edit options.lua" },
	p = { "<cmd>edit $HOME/AppData/Local/lvim/lua/sqfzy/plugins.lua<cr>", "Edit plugins.lua" },
	n = { "<cmd>edit $HOME/AppData/Local/lvim/lua/sqfzy/lsp/null-ls.lua<cr>", "Edit null-ls.lua" },
}
wk["l"]["m"] = { "<cmd>Mason<cr>", "Mason" }
wk["l"]["a"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" }
wk["l"]["I"] = nil
wk["l"]["f"] = nil
wk["F"] = {
	function()
		require("lvim.core.telescope.custom-finders").find_project_files({ previewer = false })
	end,
	"Find File",
}
wk["f"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" }

wk["r"] = {
	name = "Rust",
	r = { "<cmd>RustRunnables<CR>", "Runnables" },
	m = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
	c = { "<cmd>RustOpenCargo<CR>", "Open Cargo" },
	d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
	R = { "<cmd>lua require('crates').reload<CR>", "Reload" },
	v = { "<cmd>lua require('crates').show_versions_popup<CR>", "Show Versions" },
	f = { "<cmd>lua require('crates').show_features_popup<CR>", "Show Features" },
	D = { "<cmd>lua require('crates').show_dependencies_popup<CR>", "Show Dependencies" },
	u = { "<cmd>lua require('crates').update_crate<CR>", "Update Crate" },
	a = { "<cmd>lua require('crates').update_all_crates<CR>", "Update All Crates" },
	U = { "<cmd>lua require('crates').upgrade_crate<CR>", "Upgrade Crate" },
	A = { "<cmd>lua require('crates').upgrade_all_crates<CR>", "Upgrade All Crates" },
	e = { "<cmd>lua require('crates').expand_plain_crate_to_inline_table<CR>", "Expand Crate" },
	E = { "<cmd>lua require('crates').extract_crate_into_table<CR>", "Extract Crate" },
}
lvim.builtin.which_key.vmappings["r"] = {
	name = "Rust",
	u = { "<cmd>lua require('crates').update_crates<CR>", "Update Crate" },
	U = { "<cmd>lua require('crates').upgrade_crates<CR>", "Upgrade Crate" },
}
wk["t"] = {
	name = "Todo",
	l = { "<cmd>TodoQuickFix<CR>", "Todo list" },
	f = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
	j = { "<cmd>lua require('todo-comments').jump_next()<CR>", "Todo next" },
	k = { "<cmd>lua require('todo-comments').jump_prev()<CR>", "Todo prev" },
}
wk["T"] = nil
wk["<Space>"] = { "i<Space><Esc>", "Insert Space" }

lvim.lsp.buffer_mappings.normal_mode["gd"] = nil
lvim.lsp.buffer_mappings.normal_mode["gD"] = nil
local function show_documentation()
	local filetype = vim.bo.filetype
	if vim.tbl_contains({ "vim", "help" }, filetype) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
		require("crates").show_popup()
	elseif vim.fn.expand("%:e") == "rs" then
		vim.cmd("RustHoverActions")
	else
		vim.lsp.buf.hover()
	end
end
lvim.lsp.buffer_mappings.normal_mode["K"] = { show_documentation, "Show Documentation" }
-- lvim.lsp.buffer_mappings.normal_mode["K"] = nil
return pluginKeys
