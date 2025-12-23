local keymap = vim.keymap.set
local api = vim.api

-------------- LSP functions --------------------------

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

  keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap("n", "gb", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

  api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
  api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

  -- Whichkey
  local keymap_l = {
    { "<leader>l", group = "Code", nowait = false, remap = false },
    { "<leader>la", "<cmd>Lspsaga code_action<CR>", desc = "Action", nowait = false, remap = false },

    { "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics", nowait = false, remap = false  },
    { "<leader>lc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Cursor Diagnostics", nowait = false, remap = false  },
    { "<leader>lp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Diagnostics Prev", nowait = false, remap = false  },
    { "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Diagnostics Next", nowait = false, remap = false  },

    { "<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", desc = "Finder", nowait = false, remap = false  },
    { "<leader>lr", "<cmd>Lspsaga rename<CR>", desc = "Rename", nowait = false, remap = false  },
    { "<leader>lt", "<cmd>TroubleToggle<CR>", desc = "Trouble", nowait = false, remap = false  },

    { "<leader>lh", "<cmd>Lspsaga hover_doc<CR>", desc = "Show Hover", nowait = false, remap = false  },
    { "<leader>li", "<cmd>LspInfo<CR>", desc = "Lsp Info", nowait = false, remap = false  },

    { "<leader>d", group = "Goto", nowait = false, remap = false },
    { "<leader>dd", "<Cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition", nowait = false, remap = false  },
    { "<leader>dp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peak (Definition)", nowait = false, remap = false  },
    { "<leader>dr", "<cmd>Telescope lsp_references<CR>", desc = "References", nowait = false, remap = false  },
    { "<leader>dR", "<cmd>Trouble lsp_references<cr>", desc = "Trouble References", nowait = false, remap = false  },
    { "<leader>dD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration", nowait = false, remap = false  },
    { "<leader>dI", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation", nowait = false, remap = false  },
    { "<leader>ds", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help", nowait = false, remap = false  },
    { "<leader>dt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Type Definition", nowait = false, remap = false  },
    { "<leader>dS", "<cmd>Telescope lsp_document_symbols{}<CR>", desc = "Document Symbols", nowait = false, remap = false  },
    { "<leader>dw", "<cmd>Telescope lsp_dynamic_workspace_symbols{}<CR>", desc = "Workspace Symbols", nowait = false, remap = false  },

  }

  local keymap_l_new = {
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

  if client.server_capabilities.document_formatting then
    keymap_l.l.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
  end

  require("which-key").add(keymap_l, { buffer = bufnr, prefix = "<leader>" })
end

local function highlighting(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local lsp_highlight_grp = api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.schedule(vim.lsp.buf.document_highlight)
      end,
      group = lsp_highlight_grp,
      buffer = bufnr,
    })
    api.nvim_create_autocmd("CursorMoved", {
      callback = function()
        vim.schedule(vim.lsp.buf.clear_references)
      end,
      group = lsp_highlight_grp,
      buffer = bufnr,
    })
  end
end

local function lsp_handlers()
  local diagnostics = {
    Error = "",
    Hint = "",
    Information = "",
    Question = "",
    Warning = "",
  }
  local signs = {
    { name = "DiagnosticSignError", text = diagnostics.Error },
    { name = "DiagnosticSignWarn", text = diagnostics.Warning },
    { name = "DiagnosticSignHint", text = diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = diagnostics.Info },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- LSP handlers configuration
  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },

    diagnostic = {
      virtual_text = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        active = signs,
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
  }

  vim.diagnostic.config(config.diagnostic)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

local function formatting(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    local function format()
      local view = vim.fn.winsaveview()
      vim.lsp.buf.format({
        async = true,
        filter = function(attached_client)
          return attached_client.name ~= ""
        end,
      })
      vim.fn.winrestview(view)
    end

    local lsp_format_grp = api.nvim_create_augroup("LspFormat", { clear = true })
    -- Use "BufWritePre" for save
    api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        vim.schedule(format)
      end,
      group = lsp_format_grp,
      buffer = bufnr,
    })
  end
end

local function on_attach(client, bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  api.nvim_buf_set_option(bufnr, "completefunc", "v:lua.vim.lsp.omnifunc")

  api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  if client.server_capabilities.definitionProvider then
    api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end

  keymappings(client, bufnr)
  highlighting(client, bufnr)
  -- formatting(client, bufnr)
  -- signature_help(client, bufnr)
end

----------------------------- LSP Setup -------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp_handlers()

local server_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

----------------- LSP servers --------------------------

-- vim.lsp.config('pyright', vim.tbl_deep_extend("force", server_opts, {
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = "off",
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         diagnosticMode = "workspace",
--       },
--     },
--   },
-- }))
--
vim.lsp.config('pyright', vim.tbl_deep_extend("force", server_opts, {
  settings = {
    basedpyright = {
      analysis = {
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'standard', -- off, basic, strict, standard
        diagnosticMode = 'workspace',
        autoSearchPath = true,
        inlayHints = {
          callArgumentNames = true,
        },
      },
    },
  },
}))

vim.lsp.config('lua_ls', vim.tbl_deep_extend("force", server_opts, {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
}))

vim.lsp.config('ts_ls', vim.tbl_deep_extend("force", server_opts, {
  init_options = {
    preferences = {
      -- "shortest" | "project-relative" | "relative" | "non-relative";
      importModuleSpecifierPreference = "relative",
    },
  },
}))

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "ts_ls", "lua_ls" },
})
