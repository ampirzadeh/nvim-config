local Detail = false
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    opts = {},
    keys = {
      { "<C-b>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" }
    }
  },

  {
    'stevearc/oil.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      keymaps = {
        ["<C-p>"] = false,
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<BS>"] = { "actions.parent", mode = "n" },
        ["."] = {
          desc = "Toggle file detail view",
          callback = function()
            Detail = not Detail
            if Detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
      },
      view_options = {
        show_hidden = true,
      },
      win_options = {
        signcolumn = "auto:2",
        winbar = "%!v:lua.get_oil_winbar()",
      }
    },
    lazy = false,
    keys = {
      { "<C-b>", "<cmd>Oil<cr>", desc = "Oil" }
    },
  },
  {
    "refractalize/oil-git-status.nvim",
    lazy = false,
    dependencies = {
      "stevearc/oil.nvim",
    },
    opts = {
      show_ignored = false
    }
  },
}
