local Map = require("amp.remaps")

-- LspAttach is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = 'LSP actions',
  callback = function(event)
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

return {
  -- Love2d
  {
    "S1M0N38/love2d.nvim",
    opts = {},
    keys = {
      { "<leader>lr", "<cmd>LoveRun<cr>",  ft = "lua",   desc = "Run LÖVE" },
      { "<leader>ls", "<cmd>LoveStop<cr>", ft = "lua",   desc = "Stop LÖVE" },
    },
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'neovim/nvim-lspconfig',
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        formatting = {
          fields = { "kind", "abbr", "menu" },
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
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Esc>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
      })
    end
  },
  -- LSP
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
  }
}
