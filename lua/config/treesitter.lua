require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "regex",
    "scss",
    "sql",
    "typescript",
    "yaml",
  },
  sync_install = false,
  highlight = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
})
