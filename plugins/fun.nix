{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.cellular-automaton-nvim ];
  keymaps = [
    {
      key = "<leader>ff";
      action = "<CMD>CellularAutomaton make_it_rain<CR>";
      options.desc = "Make it rain";
    }
    {
      key = "<leader>fml";
      action = "<CMD>CellularAutomaton scramble<CR>";
      options.desc = "Scramble";
    }
  ];
}
