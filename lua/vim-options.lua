vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.number = true

local uname = vim.loop.os_uname().sysname
if uname == "Windows_NT" then
  vim.opt.shell = "powershell.exe"
elseif uname == "Darwin" then
  vim.opt.shell = "zsh"
else
  vim.opt.shell = "bash"
end


vim.keymap.set('n', '<C-w>z', ':setlocal spell spelllang=en_ca', { desc = "Enable spellcheck"})
vim.keymap.set('n', '<C-w>d', vim.diagnostic.open_float, { desc = "Show error dropdown"})
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]],{noremap=true})
