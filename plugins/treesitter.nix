{ config, ... }:
{
  extraConfigLuaPre = ''
    function shrink_node()
      if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require 'vim.treesitter._select'.select_child(vim.v.count1)
      else
        vim.lsp.buf.selection_range(-vim.v.count1)
      end
    end

    function expand_node()
      if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require 'vim.treesitter._select'.select_parent(vim.v.count1)
      else
        vim.lsp.buf.selection_range(vim.v.count1)
      end
    end
  '';

  keymaps = [
    {
      mode = [
        "x"
        "o"
      ];
      key = "<Tab>";
      action.__raw = "expand_node";
      options.desc = "Select parent node";
    }
    {
      mode = [
        "x"
        "o"
        "n"
      ];
      key = "<CR>";
      action.__raw = "expand_node";
      options.desc = "Select parent node";
    }
    {
      mode = [
        "x"
        "o"
      ];
      key = "<S-Tab>";
      action.__raw = "shrink_node";
      options.desc = "Select child node";
    }
    {
      mode = [
        "x"
        "o"
        "n"
      ];
      key = "<S-CR>";
      action.__raw = "shrink_node";
      options.desc = "Select child node";
    }

    {
      mode = "x";
      key = "[[";
      action.__raw = "function() require 'vim.treesitter._select'.select_prev(vim.v.count1) end";
      options.desc = "Select previous treesitter node";
    }
    {
      mode = "x";
      key = "]]";
      action.__raw = "function() require 'vim.treesitter._select'.select_next(vim.v.count1) end";
      options.desc = "Select next treesitter node";
    }
  ];

  plugins.treesitter-context.enable = true;

  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      ensure_installed = [ ]; # don't use this in nixvim
    };

    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      c
      cpp
      vue
      go
      svelte
      json
      javascript
      typescript
      tsx
      yaml
      html
      css
      markdown
      markdown_inline
      nix
      bash
      lua
      vim
      dockerfile
      gitignore
      rust
      zig
    ];
  };
}
