-- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
-- 	pattern = { "*.c", "*.h" },
-- 	command = "echo 'Entering a C or C++ file'",
-- })

-- 自动载入折叠
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.*" },
  command = "loadview",
})
-- 自动保存折叠
vim.api.nvim_create_autocmd("Bufleave", {
  pattern = { "*.*" },
  command = "mkview",
})

-- 删除最后一个buffer时自动切换到alpha
vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePost*",
  group = "alpha_on_empty",
  callback = function(event)
    local fallback_name = vim.api.nvim_buf_get_name(event.buf)
    local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
    local fallback_on_empty = fallback_name == "" and fallback_ft == ""

    if fallback_on_empty then
      vim.cmd("Alpha")
    end
  end,
})

-- hide statusline in alpha startup screen
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  command = "set laststatus=0",
})
-- show statusline when leave alpha startup screen
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.*",
  command = "set laststatus=2",
})
-- hide bufferline in alpha startup screen
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  command = "set showtabline=0",
})
-- show bufferline when leave alpha startup screen
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.*",
  command = "set showtabline=2",
})

-- vim.api.nvim_create_autocmd("CursorMoved", {
-- 	pattern = { "*.*" },
-- 	command = "lua require('indent_blankline').refresh()",
-- })
