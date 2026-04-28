{ lib, ... }:
{
  plugins.marks.enable = false;
  keymaps =
    builtins.concatMap
      (mark: [
        {
          key = "m${mark}";
          action = "<cmd>mark ${lib.toUpper mark}<CR>";
          options.desc = "Set mark (QWERTY are always global)";
        }
        {
          key = "'${mark}";
          action = "<cmd>normal! '${lib.toUpper mark}<CR>";
          options.desc = "Jump to mark (QWERTY are always global)";
        }
      ])
      [
        "q"
        "w"
        "e"
        "r"
        "t"
        "y"
      ];
}
