{ ... }:
{
  # PLUGIN SPECIFIC KEYMAPS ARE IN THEIR OWN RESPECTIVE FILES
  # The general (neo)vim keymaps are here

  keymaps = [
    {
      mode = "n";
      key = ";";
      action = ":";
      options.desc = "Enter command mode";
    }
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-s>";
      action = "<Esc><CMD>w<CR>";
      options.desc = "Write buffer";
    }

    {
      mode = "i";
      key = "<C-v>";
      action = "<C-r>+";
      options.desc = "Paste from clipboard";
    }

    {
      mode = "n";
      key = "<leader>x";
      action = "<CMD>bd<CR>";
      options.desc = "Close current buffer";
    }
    {
      mode = "n";
      key = "<leader><leader>";
      action = "<C-^>";
      options.desc = "Go to most recent buffer";
    }
    {
      mode = "n";
      key = "<Tab>";
      action = "<CMD>bnext<CR>";
      options.desc = "Go to next buffer";
    }
    {
      options.desc = "Go to previous buffer";
      action = "<CMD>bprevious<CR>";
      key = "<S-Tab>";
      mode = "n";
    }

    {
      mode = "n";
      key = "<A-k>";
      action = ":m .-2<CR>==";
      options.desc = "Move line up";
    }
    {
      mode = "n";
      key = "<A-j>";
      action = ":m .+1<CR>==";
      options.desc = "Move line down";
    }

    {
      mode = "i";
      key = "<A-k>";
      action = "<Esc>:m .-2<CR>==gi";
      options.desc = "Move line up";
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<Esc>:m .+1<CR>==gi";
      options.desc = "Move line down";
    }

    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move selection up";
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move selection down";
    }

    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Move to left split";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Move to bottom split";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Move to top split";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Move to right split";
    }

    {
      mode = "t";
      key = "<C-h>";
      action = "<CMD>wincmd h<CR>";
      options.desc = "Move to left split";
    }
    {
      mode = "t";
      key = "<C-j>";
      action = "<CMD>wincmd j<CR>";
      options.desc = "Move to bottom split";
    }
    {
      mode = "t";
      key = "<C-k>";
      action = "<CMD>wincmd k<CR>";
      options.desc = "Move to top split";
    }
    {
      mode = "t";
      key = "<C-l>";
      action = "<CMD>wincmd l<CR>";
      options.desc = "Move to right split";
    }

    {
      mode = "n";
      key = "<C-Up>";
      action = "<CMD>resize -2<CR>";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<CMD>resize +2<CR>";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<CMD>vertical resize -2<CR>";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<CMD>vertical resize +2<CR>";
    }

    {
      mode = "t";
      key = "<C-Up>";
      action = "<CMD>resize -2<CR>";
    }
    {
      mode = "t";
      key = "<C-Down>";
      action = "<CMD>resize +2<CR>";
    }
    {
      mode = "t";
      key = "<C-Left>";
      action = "<CMD>vertical resize -2<CR>";
    }
    {
      mode = "t";
      key = "<C-Right>";
      action = "<CMD>vertical resize +2<CR>";
    }

    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
      options.desc = "Join line, keeping the cursor position";
    }

    {
      mode = "n";
      key = "<leader>r";
      action = ":%s/\<C-r><C-w>/<C-r><C-w>/g<Left><Left>";
      options = {
        silent = false;
        desc = "Search and replace entire word in normal mode";
      };
    }
    {
      mode = "v";
      key = "<leader>r";
      action = "\"hy:%s/<C-r>h//g<Left><Left>";
      options = {
        silent = false;
        desc = "Search and replace entire selection in visual mode";
      };
    }

    {
      mode = "n";
      key = "<leader>v";
      action = "<CMD>split<CR>";
      options.desc = "Open split buffer horizontally";
    }
    {
      mode = "n";
      key = "<leader>h";
      action = "<CMD>vsplit<CR>";
      options.desc = "Open split buffer vertically";
    }

    {
      mode = "n";
      key = "<leader>d";
      action = "<CMD>lua vim.diagnostic.open_float()<CR>";
      options.desc = "Open diagnostics";
    }

  ]
  ++ builtins.genList (
    i:
    let
      n = i + 1;
    in
    {
      key = "<C-${toString n}>";
      action.__raw = ''
        function()
          local bufs = vim.fn.getbufinfo({ buflisted = 1 })
          if bufs[${toString n}] then
            vim.api.nvim_set_current_buf(bufs[${toString n}].bufnr)
          end
        end
      '';
      options.desc = "Go to buffer ${toString n}";
    }
  ) 9;
}
