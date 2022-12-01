-- default settings
require("mini.cursorword").setup({})
require("mini.comment").setup({
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    -- comment = 'gc',

    -- Toggle comment on current line
    -- comment_line = 'gcc',
    comment_line = ',cl',

    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    -- textobject = 'gc',
  },
})
require("mini.surround").setup({})
require("mini.tabline").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.bufremove").setup({})
require("mini.doc").setup({})
require("mini.ai").setup({})

-- custom settings
require("config.mini.base16")
require("config.mini.statusline")
