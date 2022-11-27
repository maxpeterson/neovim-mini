local api = vim.api

-- Highlight on yank
api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  autocmd BufEnter *.md exe 'noremap <leader>p :!open -a "Google Chrome.app" %:p<CR>'
  ]],
	false
)
