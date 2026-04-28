{ ... }:
{
  plugins.web-devicons.enable = true;

  colorschemes.onedark.enable = true;

  diagnostic.settings = {
    float = {
      focusable = false;
      style = "minimal";
      border = "rounded";
      source = true;
      header = "";
      prefix = "";
    };
    virtual_text = true;
    signs = true;
    underline = true;
    update_in_insert = false;
    severity_sort = true;
  };
}
