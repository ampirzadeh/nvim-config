{ ... }:
{
  globals = {
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    mapleader = " ";
    maplocalleader = ",";
  };

  opts = {
    # UI options
    showmode = false; # hides the --INSERT-- --NORMAL-- text under the statusline
    number = true; # show line numbers
    relativenumber = true; # show line numbers relative to the cursor line
    wrap = false; # don't wrap lines
    whichwrap.__raw = ''vim.opt.whichwrap + "hl"''; # move to the next line when the cursor reaches the end
    cursorline = true; # highlight the current line
    ruler = true; # show the cursor position in the status line (it is currently redundant because of the lualine plugin)
    title = true; # set the title of the terminal window to the name of the file
    hlsearch = false; # disable persistent search highlights
    incsearch = true; # highlights matches incrementally as they're being typed
    scrolloff = 4; # keeps at least 4 lines visible above and below the cursor
    signcolumn = "yes:2"; # keep two columns of space to the left of line numbers
    termguicolors = true; # enable 24-bit RGB colours

    # Indentation
    autoindent = true; # copy indentation from current line when starting a new line
    expandtab = true; # use spaces instead of tabs
    shiftwidth = 2; # number of spaces to use for each step of (auto)indent
    tabstop = 2; # number of spaces a tab character visually occupies
    smartindent = true; # add extra indentation after {

    # File options
    swapfile = false; # disable swap files
    backup = false; # disable backup files
    undodir.__raw = ''os.getenv("HOME") .. "/.vim/undodir"''; # save undo history
    undofile = true; # enable persistent undo to allow undoing after closing a file

    # Clipboard
    clipboard = "unnamedplus"; # use the system clipboard
  };
}
