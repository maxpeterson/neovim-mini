local g = vim.g
local api = vim.api
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Space as leader key
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = ","
g.maplocalleader = ","

g.taboo_tab_format = ' %N:%P '
g.argwrap_tail_comma = 1
g.argwrap_padded_braces = '{'

-- Word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Resizing panes
keymap("n", "<A-Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<A-Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<A-Up>", ":resize -1<CR>", default_opts)
keymap("n", "<A-Down>", ":resize +1<CR>", default_opts)

-- Remap leap bindings s/S => f/F
keymap("n", "f", "<Plug>(leap-forward-to)", default_opts)
keymap("n", "F", "<Plug>(leap-backward-to)", default_opts)

-- Terminal
keymap("t", "<C-Esc>", "<C-\\><C-n><cmd>ToggleTerm<cr>", default_opts)
keymap("t", "<C-w><Left>", "<C-\\><C-n><C-w>h", default_opts)
keymap("t", "<C-w><Down>", "<C-\\><C-n><C-w>j", default_opts)
keymap("t", "<C-w><Up>", "<C-\\><C-n><C-w>k", default_opts)
keymap("t", "<C-w><Right>", "<C-\\><C-n><C-w>l", default_opts)
