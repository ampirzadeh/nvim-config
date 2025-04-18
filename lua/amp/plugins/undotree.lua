return {
  "mbbill/undotree",
  config = function()
    local Map = require("amp.remaps")

    Map('n', 'U', ":UndotreeToggle<CR>")
  end,
}
