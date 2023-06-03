local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
--Remap space as leader key
-- map("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.api.nvim_feedkeys() 插入一个字符

-------------------------------  normal ---------------------------------------------
lvim.keys.normal_mode = {
	-- Better window movement
	["<C-h>"] = "<C-w>h",
	["<C-j>"] = "<C-w>j",
	["<C-k>"] = "<C-w>k",
	["<C-l>"] = "<C-w>l",
	["<C-w>"] = "<C-w>w",

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
}
-- for k, v in pairs(normal) do
-- 	map("n", k, v, opts)
-- end

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

	["<S-a><S-a>"] = "<Esc><S-a>",
	["<S-i><S-i>"] = "<Esc><S-i>",
	["<A-l>"] = function()
		require("luasnip").jump(1)
	end,
	["<A-h>"] = function()
		require("luasnip").jump(-1)
	end,
}
-- function test()
-- 	if vim.filetype.match({ filename = { "*.c", "*.cpp" } }) then
-- 		map("i", "-", "->", opts)
-- 	else
-- 		map("i", "-", "", opts)
-- 	end
-- end
-- for k, v in pairs(insert) do
-- 	map("i", k, v, opts)
-- end

-------------------------------  visual ---------------------------------------------
lvim.keys.visual_mode = {
	-- Better indenting
	["<"] = "<gv",
	[">"] = ">gv",
	["<A-j>"] = ":m '>+1<CR>gv-gv",
	["<A-k>"] = ":m '<-2<CR>gv-gv",

	["L"] = "$",
	["H"] = "^",
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
-- for k, v in pairs(visual) do
-- 	map("v", k, v, opts)
-- end

-------------------------------  visual-block ---------------------------------------------
lvim.keys.visual_block_mode = {
	-- Move current line / block with Alt-j/k ala vscode.
	["<A-j>"] = ":m '>+1<CR>gv-gv",
	["<A-k>"] = ":m '<-2<CR>gv-gv",
}
-- for k, v in pairs(visual_block_mode) do
-- 	map("x", k, v, opts)
-- end

-- -------------------------------  term ---------------------------------------------
-- local term_mode = {
-- 	-- Terminal window navigation
-- 	["<C-h>"] = "<C-\\><C-N><C-w>h",
-- 	["<C-j>"] = "<C-\\><C-N><C-w>j",
-- 	["<C-k>"] = "<C-\\><C-N><C-w>k",
-- 	["<C-l>"] = "<C-\\><C-N><C-w>l",
-- }
-- for k, v in pairs(term_mode) do
-- 	map("t", k, v, opts)
-- end

-------------------------------  command ---------------------------------------------
-- local command_mode = {
-- 	-- navigate tab completion with <c-j> and <c-k>
-- 	-- runs conditionally
-- 	["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
-- 	["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
-- }
-- for k, v in pairs(command_mode) do
-- 	map("c", k, v[1], v[2])
-- end

-------------------------------  select ---------------------------------------------
local select_mode = {
	["p"] = "p",
	["d"] = "d",
	["<BS>"] = "<BS>i",
}
for k, v in pairs(select_mode) do
   map("s", k, v, opts)
end

---------------------------------------------------------------------
----------------------------- Plugins ----------------------------------
---------------------------------------------------------------------
local pluginKeys = {}

----------------------------- NvimTree ---------------------------------
pluginKeys.set_nvimtree_keymaps = function(bufnr)
	local api = require("nvim-tree.api")

	local function opt(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
	vim.keymap.set("n", "a", api.fs.create, opt("Create")) -- 新建
	vim.keymap.set("n", "l", api.node.open.edit, opt("Open")) -- 打开
	vim.keymap.set("n", "L", api.tree.expand_all, opt("Expand All")) -- 展开所有
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opt("Close Directory")) -- 关闭
	vim.keymap.set("n", "H", api.tree.collapse_all, opt("Collapse")) -- 折叠所有
	vim.keymap.set("n", "d", api.fs.remove, opt("Delete")) -- 删除
	vim.keymap.set("n", "c", api.fs.copy.node, opt("Copy")) -- 复制
	vim.keymap.set("n", "p", api.fs.paste, opt("Paste")) -- 粘贴
	vim.keymap.set("n", "C", api.tree.change_root_to_node, opt("CD")) -- 切换目录
	vim.keymap.set("n", "r", api.fs.rename, opt("Rename")) -- 重命名
	vim.keymap.set("n", "x", api.fs.cut, opt("Cut")) -- 剪切
	vim.keymap.set("n", "y", api.fs.copy.filename, opt("Copy Name")) -- 复制文件名
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opt("Copy Relative Path")) -- 复制相对路径
	vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opt("Copy Absolute Path")) -- 复制绝对路径
	vim.keymap.set("n", "s", api.node.run.system, opt("Run System")) -- 运行系统命令
	vim.keymap.set("n", "S", api.tree.search_node, opt("Search")) -- 搜索
	vim.keymap.set("n", "f", api.live_filter.start, opt("Filter")) -- 过滤
	vim.keymap.set("n", "R", api.tree.reload, opt("Refresh")) -- 刷新
	vim.keymap.set("n", "K", api.node.show_info_popup, opt("Info")) -- 显示信息
	vim.keymap.set("n", "<A-v>", api.node.open.vertical, opt("Open: Vertical Split")) -- 垂直分屏
	vim.keymap.set("n", "<A-x>", api.node.open.horizontal, opt("Open: Horizontal Split")) -- 水平分屏
	vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opt("Toggle Dotfiles")) -- 显示隐藏文件
end
----------------------------- bufferline ---------------------------------
-- pluginKeys.set_buffline_keymaps = function()
--   map("n", "<A-h>", ":BufferLineCyclePrev<CR>", opts) -- 前一个标签
--   map("n", "<A-l>", ":BufferLineCycleNext<CR>", opts) -- 后一个标签
--   map("n", "<A-c>", "<cmd>Bdelete!<CR>", opts)        -- 关闭标签
-- end

pluginKeys.telescope_keymaps = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		["<C-n>"] = "move_selection_next",
		["<C-p>"] = "move_selection_previous",
		-- -- 历史记录
		-- ["<C-n>"] = "cycle_history_next",
		-- ["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<leader>q"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
	n = {
		["<leader>q"] = "close",
	},
}

---------------------------- Lsp ---------------------------------
pluginKeys.set_lsp_keymaps = function(bufnr)
	local buf_map = vim.api.nvim_buf_set_keymap
	buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_map(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- 窗口中编辑定义
	buf_map(bufnr, "n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- 跳转到定义
	buf_map(bufnr, "n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts) -- 窗口中的类型声明
	buf_map(bufnr, "n", "gT", "<cmd>Lspsaga goto_type_definition<CR>", opts) -- 跳转到类型声明
	buf_map(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- 窗口查看报错
	buf_map(bufnr, "n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- 查找定义，声明等
	buf_map(bufnr, "n", "<A-3>", "<cmd>Lspsaga term_toggle<CR>", opts) -- 终端
	buf_map(bufnr, "t", "<A-3>", "<cmd>Lspsaga term_toggle<CR>", opts) -- 终端
end

-------------------------------  lunsnip快捷键  ---------------------------------------------
pluginKeys.set_lunsnip_keymaps = function()
	--切换补全
	map("i", "<A-n>", "<Plug>luasnip-next-choice", opts)
	map("s", "<A-n>", "<Plug>luasnip-next-choice", opts)
	map("i", "<A-p>", "<Plug>luasnip-prev-choice", opts)
	map("s", "<A-p>", "<Plug>luasnip-prev-choice", opts)
end

-------------------- leap ------------------------------
pluginKeys.set_leap_keymaps = function()
	map("n", "f", "<Plug>(leap-forward-to)", opts)
	map("n", "F", "<Plug>(leap-backward-to)", opts)
	map("n", "s", "<Plug>(leap-forward-till)", opts)
	map("n", "S", "<Plug>(leap-backward-till)", opts)
	map("n", "<C-f>", "<Plug>(leap-from-window)", opts)
end

vim.g.VM_default_mappings = 0
pluginKeys.set_multi_keymaps = function()
	vim.g.VM_maps = {}
	vim.g.VM_maps = {
		["Remove Region"] = "<C-p>",
		["Select All"] = "<C-A-n>",
	}
end

lvim.builtin.cmp.confirm_opts.select = true
lvim.builtin.cmp.mapping["<Tab>"] = require("cmp").mapping.confirm({ select = true })

lvim.builtin.which_key.mappings["W"] =
	{ "<cmd>lua require('lvim.lsp.utils').format()<cr><cmd>w!<cr>", "Save with format" }
lvim.builtin.which_key.mappings["j"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" }
lvim.builtin.which_key.mappings["k"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" }
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<CR>", "ZenMode" }
lvim.builtin.which_key.mappings["c"] = {
	name = "Copilot",
	{
		e = { "<cmd>Copilot disable<CR>", "Copilot disable" },
		b = { "<cmd>Copilot enable<CR>", "Copilot enable" },
		E = { "<cmd>lua require('copilot.suggestion').dismiss()<cr>", "Copilot dismiss" },
	},
}

return pluginKeys
