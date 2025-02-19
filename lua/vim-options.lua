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

-- Enable home and end keys to go to start and end of line
vim.keymap.set('n', '<Home>', '^', { noremap = true, silent = true })
vim.keymap.set('n', '<End>', 'g_', { noremap = true, silent = true })
vim.keymap.set('i', '<Home>', '<C-o>^', { noremap = true, silent = true })
vim.keymap.set('i', '<End>', '<C-o>g_', { noremap = true, silent = true })
-- Enable spellcheck
vim.keymap.set('n', '<C-w>z', ':setlocal spell spelllang=en_ca', { desc = "Enable spellcheck" })
-- Expand error and warning dropdowns
vim.keymap.set('n', '<C-w>d', vim.diagnostic.open_float, { desc = "Show error dropdown" })
-- Map escape to terminal defocus
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
