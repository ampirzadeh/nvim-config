return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load() -- Load VS Code-style snippets
    end,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')

      cmp.setup({
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({ mode = "symbol" })
        },
        -- experimental = {
        --   ghost_text = true,
        -- },
        completion = {
          completeopt = 'menu,menuone,noinsert'
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" }
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Esc>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        init = function() require('mason').setup() end
      },
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function()
      local lsp_defaults = require("lspconfig").util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = 'LSP actions',
        callback = function(event)
          local Map = require("amp.remaps")
          local opts = { buffer = event.buf }

          Map("n", "<leader>d", vim.diagnostic.open_float, opts)
          Map("n", "K", vim.lsp.buf.hover, opts)
          Map("n", "gd", vim.lsp.buf.definition, opts)
          Map("n", "gD", vim.lsp.buf.declaration, opts)
          Map("n", "gi", vim.lsp.buf.implementation, opts)
          Map("n", "go", vim.lsp.buf.type_definition, opts)
          Map("n", "gr", vim.lsp.buf.references, opts)
          Map("n", "gs", vim.lsp.buf.signature_help, opts)
          Map("n", '<F2>', vim.lsp.buf.rename, opts)
          Map("n", '<A-x>', function() vim.lsp.buf.format { async = true } end, opts)
          Map("n", '<F4>', vim.lsp.buf.code_action, opts)
        end,
      })

      require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = {},
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  diagnostics = { globals = { 'vim' } },
                  workspace = {
                    library = {
                      vim.api.nvim_get_runtime_file("", true),
                      "${3rd}/love2d/library",
                    },
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end
        }
      })
    end
  }
}
