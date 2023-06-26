local hr = tonumber(os.date("%H", os.time()))
if hr > 7 and hr < 20 then
  lvim.colorscheme = "tokyonight-day"
  -- vim.cmd.colorscheme("github_light")
else
  lvim.colorscheme = "tokyonight-moon"
  -- vim.cmd.colorscheme("catppuccin")
end
