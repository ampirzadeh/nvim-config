{ ... }:
{
  plugins.notify = {
    enable = true;
    settings = {
      stages = "static";
      timeout = 3000;
      max_height.__raw = "function() return math.floor(vim.o.lines * 0.75) end";
      max_width.__raw = "function() return math.floor(vim.o.columns * 0.75) end";
      on_open.__raw = "function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end";
    };
  };
}
