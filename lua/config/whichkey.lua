local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    win = {
      border = "single", -- none, single, double, shadow
    },
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
    { "<leader>b", group = "Buffer", nowait = false, remap = false },
    { "<leader>bD", "<Cmd>%bd|e#|bd#<Cr>", desc = "Delete all buffers", nowait = false, remap = false },
    { "<leader>bc", "<Cmd>bd!<Cr>", desc = "Close current buffer", nowait = false, remap = false },
    { "<leader>c", group = "Comment", nowait = false, remap = false },
    { "<leader>e", group = "Terminal", nowait = false, remap = false },
    { "<leader>eT", "<cmd>ToggleTerm direction=tab<cr>", desc = "Tab", nowait = false, remap = false },
    { "<leader>ee", "<cmd>ToggleTerm<cr>", desc = "Toggle", nowait = false, remap = false },
    { "<leader>ef", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = false, remap = false },
    { "<leader>eh", "<cmd>ToggleTerm direction=horizontal size=20<cr>", desc = "Horizontal", nowait = false, remap = false },
    { "<leader>ev", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical", nowait = false, remap = false },
    { "<leader>f", group = "Find", nowait = false, remap = false },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", nowait = false, remap = false },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = false, remap = false },
    { "<leader>fd", "<cmd>lua require('utils.finder').find_dotfiles()<cr>", desc = "Dotfiles", nowait = false, remap = false },
    { "<leader>fe", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", nowait = false, remap = false },
    { "<leader>ff", "<cmd>lua require('utils.finder').find_files()<cr>", desc = "Files", nowait = false, remap = false },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", nowait = false, remap = false },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Old Files", nowait = false, remap = false },
    { "<leader>fp", "<cmd>lua require'telescope'.extensions.project.project{}<cr>", desc = "Project List", nowait = false, remap = false },
    { "<leader>fr", "<cmd>Telescope file_browser<cr>", desc = "Browser", nowait = false, remap = false },
    { "<leader>fs", "<cmd>Telescope repo list<cr>", desc = "Project Search", nowait = false, remap = false },
    { "<leader>fw", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer", nowait = false, remap = false },
    { "<leader>g", group = "Git", nowait = false, remap = false },
    { "<leader>gb", "<cmd>Neogit brannch<CR>", desc = "Branch", nowait = false, remap = false },
    { "<leader>gc", "<cmd>Neogit commit<CR>", desc = "Commit", nowait = false, remap = false },
    { "<leader>gl", "<cmd>Neogit pull<CR>", desc = "Pull", nowait = false, remap = false },
    { "<leader>gp", "<cmd>Neogit push<CR>", desc = "Push", nowait = false, remap = false },
    { "<leader>gs", "<cmd>Neogit<CR>", desc = "Status", nowait = false, remap = false },
    { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = false, remap = false },
    { "<leader>s", "<cmd>update!<CR>", desc = "Save", nowait = false, remap = false },
    { "<leader>t", group = "Tab", nowait = false, remap = false },
    { "<leader>t<left>", "<cmd>tabp<cr>", desc = "Previouse", nowait = false, remap = false },
    { "<leader>t<right>", "<cmd>tabn<cr>", desc = "Next", nowait = false, remap = false },
    { "<leader>ta", "<cmd>tabnew<cr>", desc = "New", nowait = false, remap = false },
    { "<leader>tc", "<cmd>tabclose<cr>", desc = "Close", nowait = false, remap = false },
    { "<leader>tmn", "<cmd>+tabmove<cr>", desc = "Move Down", nowait = false, remap = false },
    { "<leader>tmp", "<cmd>-tabmove<cr>", desc = "Move Up", nowait = false, remap = false },
    { "<leader>tn", "<cmd>tabn<cr>", desc = "Next", nowait = false, remap = false },
    { "<leader>to", "<cmd>tabonly<cr>", desc = "Only", nowait = false, remap = false },
    { "<leader>tp", "<cmd>tabp<cr>", desc = "Previouse", nowait = false, remap = false },
    { "<leader>w", "<cmd>ArgWrap<cr>", desc = "Wrap", nowait = false, remap = false },
    { "<leader>z", group = "Packer", nowait = false, remap = false },
    { "<leader>zS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = false, remap = false },
    { "<leader>zc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = false, remap = false },
    { "<leader>zi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = false, remap = false },
    { "<leader>zs", "<cmd>PackerSync<cr>", desc = "Sync", nowait = false, remap = false },
    { "<leader>zu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = false, remap = false },
  }

  whichkey.setup(conf)
  whichkey.add(mappings, opts)
end

return M
