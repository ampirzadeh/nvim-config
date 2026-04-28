{ ... }:
{
  autoCmd = [
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }
    {
      event = "VimResized";
      command = "wincmd =";
    }

    {
      event = "TextYankPost";
      desc = "Highlight selection on yank";
      pattern = "*";
      callback.__raw = "function() vim.hl.on_yank({ timeout = 200, visual = true }) end";
    }

    {
      event = "BufReadPost";
      desc = "Restore cursor to file position in previous editing session";
      callback.__raw = ''
        function(args)
            local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
            local line_count = vim.api.nvim_buf_line_count(args.buf)
            if mark[1] > 0 and mark[1] <= line_count then
              vim.api.nvim_win_set_cursor(0, mark)
              vim.schedule(function()
                vim.cmd("normal! zz")
              end)
            end
          end'';
    }

    {
      event = "CursorMoved";
      desc = "Highlight references under cursor";
      callback.__raw = ''
        function()
            if vim.fn.mode() ~= "i" then
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              local supports_highlight = false
              for _, client in ipairs(clients) do
                if client.server_capabilities.documentHighlightProvider then
                  supports_highlight = true
                  break
                end
              end

              if supports_highlight then
                vim.lsp.buf.clear_references()
                vim.lsp.buf.document_highlight()
              end
            end
          end
      '';
    }
    {
      event = "CursorMovedI";
      desc = "Clear highlights when entering insert mode";
      callback.__raw = "function() vim.lsp.buf.clear_references() end";
    }

    {
      event = [
        "WinEnter"
        "BufEnter"
      ];
      desc = "Highlight cursor line on active buffer";
      callback.__raw = "function() vim.opt_local.cursorline = true end";
    }
    {
      event = [
        "WinLeave"
        "BufLeave"
      ];
      desc = "Clear highlight of cursor line when leaving the buffer";
      callback.__raw = "function() vim.opt_local.cursorline = false end";
    }

    {
      event = "BufRead";
      desc = "Set correct filetype for dotenv files";
      pattern = [
        ".env"
        ".env.*"
      ];
      callback.__raw = "function() vim.bo.filetype = 'dosini' end";
    }
  ];
}
