local keymap = vim.keymap.set
local api = vim.api

----------------- LSP servers --------------------------
local servers = {
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
  sumneko_lua = {
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
  },
  tsserver = {
    init_options = {
      preferences = {
        -- "shortest" | "project-relative" | "relative" | "non-relative";
        importModuleSpecifierPreference = "relative",
      },
    },
  },
}

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
    l = {
      name = "Code",
      -- a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Action" },
      a = { "<cmd>Lspsaga code_action<CR>", "Action" },

      -- d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
      d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
      c = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Cursor Diagnostics" },
      p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Diagnostics Prev" },
      n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Diagnostics Next" },


      f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
      r = { "<cmd>Lspsaga rename<CR>", "Rename" },
      t = { "<cmd>TroubleToggle<CR>", "Trouble" },
      -- h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show Hover" },
      h = { "<cmd>Lspsaga hover_doc<CR>", "Show Hover" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
    },

    d = {
      name = "Goto",
      d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
      p = { "<cmd>Lspsaga peek_definition<CR>", "Peak (Definition)" },
      r = { "<cmd>Telescope lsp_references<CR>", "References" },
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
      I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
      S = { "<cmd>Telescope lsp_document_symbols{}<CR>", "Document Symbols" },
      w = { "<cmd>Telescope lsp_dynamic_workspace_symbols{}<CR>", "Workspace Symbols" },
    }
  }
  if client.server_capabilities.document_formatting then
    keymap_l.l.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
  end

  require("which-key").register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
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
  formatting(client, bufnr)
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

require("mason").setup({})

require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = false,
})

local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
  function(server_name)
    local extended_opts = vim.tbl_deep_extend("force", server_opts, servers[server_name] or {})
    lspconfig[server_name].setup(extended_opts)
  end,
  -- You can set up other server specific config
})
