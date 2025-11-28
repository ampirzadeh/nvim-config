-- Just fun and unneccary plugins
return {
  {
    'eandrju/cellular-automaton.nvim',
    config = function()
      local Map = require("amp.remaps")

      Map("n", "<leader>ff", "<cmd>CellularAutomaton make_it_rain<CR>")
      Map("n", "<leader>fml", "<cmd>CellularAutomaton scramble<CR>")
    end,
  }
}
