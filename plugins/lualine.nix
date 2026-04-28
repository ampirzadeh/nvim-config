{ ... }:
{
  plugins.lualine = {
    enable = true;
    settings = {
      tabline = {
        lualine_a = [ "buffers" ];
      };
      sections = {
        lualine_b = [
          "branch"
          "diagnostics"
        ];
        lualine_y = [ "lsp_status" ];
      };
    };
  };
}
