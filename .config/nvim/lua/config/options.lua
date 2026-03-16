-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
--
vim.g.vimtex_view_method = "zathura_simple"
vim.opt.termguicolors = true
-- Imposta il font e la dimensione (es. altezza 12)
vim.o.guifont = "IosevkaTerm Nerd Font:h16"

vim.cmd([[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]])
