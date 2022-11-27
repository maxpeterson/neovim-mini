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

-- jk to ESC
keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

local keys = {
  ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}

_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- If popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
  else
    -- If popup is not visible, use plain `<CR>`. You might want to customize
    -- according to other plugins. For example, to use 'mini.pairs', replace
    -- next line with `return require('mini.pairs').cr()`
    return keys['cr']
  end
end

api.nvim_set_keymap('i', '<CR>', 'v:lua._G.cr_action()', { noremap = true, expr = true })

-- Resizing panes
keymap("n", "<A-Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<A-Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<A-Up>", ":resize -1<CR>", default_opts)
keymap("n", "<A-Down>", ":resize +1<CR>", default_opts)

-- Terminal
keymap("t", "<C-Esc>", "<C-\\><C-n><cmd>ToggleTerm<cr>", default_opts)
keymap("t", "<C-w><Left>", "<C-\\><C-n><C-w>h", default_opts)
keymap("t", "<C-w><Down>", "<C-\\><C-n><C-w>j", default_opts)
keymap("t", "<C-w><Up>", "<C-\\><C-n><C-w>k", default_opts)
keymap("t", "<C-w><Right>", "<C-\\><C-n><C-w>l", default_opts)
