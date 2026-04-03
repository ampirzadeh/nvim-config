-- Just fun and unneccary plugins
return {
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { "<leader>ff",  "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain" },
      { "<leader>fml", "<cmd>CellularAutomaton scramble<CR>",     desc = "Scramble" }
    },
  }
}
