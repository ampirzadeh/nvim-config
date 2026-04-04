local languages = {
  "c",
  "cpp",
  "vue",
  "svelte",
  "json",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "html",
  "css",
  "markdown",
  "markdown_inline",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "gitignore",
  "rust",
  "zig"
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.install(languages)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  }
}
