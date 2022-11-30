local cmd = vim.cmd
local fn = vim.fn
local api = vim.api

-- Global object
_G.NVMM = {}

local packer_bootstrap = false -- Indicate first time installation

-- packer.nvim configuration
local conf = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },

  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
}

local function packer_init()
  -- Check if packer.nvim is installed
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    cmd([[packadd packer.nvim]])
  end

  -- Run PackerCompile if there are changes in this file
  local packerGrp = api.nvim_create_augroup("packer_user_config", { clear = true })
  api.nvim_create_autocmd(
    { "BufWritePost" },
    { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packerGrp }
  )
end

-- Plugins
local function plugins(use)
  use({ "wbthomason/packer.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lua/plenary.nvim" })
  use {
    "sainnhe/everforest",
    config = function()
      vim.cmd "colorscheme everforest"
    end,
  }
  use({
    "TimUntersberger/neogit",
    cmd = { "Neogit" },
    config = function()
      require("neogit").setup({})
    end,
  })
  use "pbrisbin/vim-mkdir"
  use "FooSoft/vim-argwrap"
  use 'mattkubej/jest.nvim'
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
  use {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end,
  }
  use {
    "windwp/nvim-autopairs",
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
      require("config.autopairs").setup()
    end,
  }
  use {
    "windwp/nvim-ts-autotag",
    wants = "nvim-treesitter",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup { enable = true }
    end,
  }
  use {
    "RRethy/nvim-treesitter-endwise",
    wants = "nvim-treesitter",
    event = "InsertEnter",
  }
  use {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.whichkey").setup()
    end,
  }
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup()
    end,
  }
  use {
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup()
    end,
  }
  use "gcmt/taboo.vim"
  use {
    "ahmedkhalf/project.nvim",
    -- event = "BufRead",
    config = function()
      require("project_nvim").setup {}
    end,
  }
  use {
    "folke/trouble.nvim",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
      }
    end,
  }
  use {
    "tami5/lspsaga.nvim",
    event = "VimEnter",
    cmd = { "Lspsaga" },
    config = function()
      require("lspsaga").setup {}
    end,
  }
  use { "junegunn/fzf", run = "./install --all" }
  use {
    "ibhagwan/fzf-lua",
    requires = { "kyazdani42/nvim-web-devicons" },
  }
  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require("config.telescope").setup()
    end,
    cmd = { "Telescope" },
    module = "telescope",
    keys = { "<leader>f", "<leader>p" },
    wants = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-fzf-native.nvim",
      "telescope-project.nvim",
      "telescope-repo.nvim",
      "telescope-file-browser.nvim",
      "project.nvim",
    },
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-project.nvim",
      "cljoly/telescope-repo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
  }
  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.cmp").setup()
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "hrsh7th/cmp-calc",
      -- "f3fora/cmp-spell",
      -- "hrsh7th/cmp-emoji",
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require("config.luasnip")
        end,
      },
      "rafamadriz/friendly-snippets",
      "petertriho/cmp-git",
    },
    disable = false,
  }
  use({
    "echasnovski/mini.nvim",
    config = function()
      require("config.mini")
    end,
  })
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    wants = {
      "cmp-nvim-lsp",
      "LuaSnip",
    },
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("config.lsp")
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  })
  use({ "nvim-treesitter/playground" })

  -- Bootstrap Neovim
  if packer_bootstrap then
    print("Neovim restart is required after installation!")
    require("packer").sync()
  end
end

-- packer.nvim
packer_init()
local packer = require("packer")
packer.init(conf)
packer.startup(plugins)
