{ ... }:
{
  lsp = {
    servers = {
      lua_ls = {
        enable = true;
        config = {
          settings = {
            "Lua" = {
              diagnostics.globals = [
                "vim"
                "require"
              ];
              telemetry.enable = false;
            };
          };
        };
      };
      ts_ls.enable = true;
      rust_analyzer.enable = true;
      nil_ls.enable = true;
      gopls.enable = true;
      html.enable = true;
      zls = {
        enable = true;
        config = {
          settings = {
            zls = {
              enable_build_on_save = true;
            };
          };
        };
      };
    };

    keymaps = [
      {
        key = "K";
        lspBufAction = "hover";
      }
      {
        key = "gd";
        lspBufAction = "definition";
      }
      {
        key = "gD";
        lspBufAction = "declaration";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
      }
      {
        key = "go";
        lspBufAction = "type_definition";
      }
      {
        key = "gr";
        lspBufAction = "references";
      }
      {
        key = "gs";
        lspBufAction = "signature_help";
      }
      {
        key = "<F2>";
        lspBufAction = "rename";
      }
      {
        key = "<A-x>";
        lspBufAction = "format";
      }
      {
        key = "<F4>";
        lspBufAction = "code_action";
      }
      {
        key = "<leader>ih";
        action = {
          __raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end";
        };
        options.desc = "Toggle inlay hints";
      }

    ];
  };
  plugins.lspconfig.enable = true;
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      formatting.fields = [
        "kind"
        "abbr"
        "menu"
      ];

      completion.completeopt = "menu,menuone,noinsert";

      sources = [
        { name = "nvim-lsp"; }
        { name = "nvim-lsp-signature-help"; }
        { name = "buffer"; }
        { name = "path"; }
        { name = "cmdline"; }
      ];

      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-u>" = "cmp.mapping.scroll_docs(-4)";
        "<C-d>" = "cmp.mapping.scroll_docs(4)";
        "<Esc>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm()";
        "<Tab>" = "cmp.mapping.select_next_item()";
        "<S-Tab>" = "cmp.mapping.select_prev_item()";
      };
    };
  };
  plugins.nvim-autopairs.enable = true;
}
