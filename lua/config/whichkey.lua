local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local keymaps_f = {
    name = "Find",
    f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
    d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    r = { "<cmd>Telescope file_browser<cr>", "Browser" },
    w = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "Project List" },
    s = { "<cmd>Telescope repo list<cr>", "Project Search" },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["s"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    t = {
      name = "Tab",
      a = { "<cmd>tabnew<cr>", "New" },
      c = { "<cmd>tabclose<cr>", "Close" },
      o = { "<cmd>tabonly<cr>", "Only" },
      n = { "<cmd>tabn<cr>", "Next" },
      p = { "<cmd>tabp<cr>", "Previouse" },
      ["<right>"] = { "<cmd>tabn<cr>", "Next" },
      ["<left>"] = { "<cmd>tabp<cr>", "Previouse" },
      mp = { "<cmd>-tabmove<cr>", "Move Up" },
      mn = { "<cmd>+tabmove<cr>", "Move Down" },
    },

    e = {
      name = "Terminal",
      e = { "<cmd>ToggleTerm<cr>", "Toggle" },
      v = { "<cmd>ToggleTerm direction=vertical size=80<cr>", "Vertical" },
      h = { "<cmd>ToggleTerm direction=horizontal size=20<cr>", "Horizontal" },
      f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
      T = { "<cmd>ToggleTerm direction=tab<cr>", "Tab" },
    },

    w = { "<cmd>ArgWrap<cr>", "Wrap" },

    c = {
      name = "Comment",
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },

    f = keymaps_f,
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
