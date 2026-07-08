-- Diagnostics UI
vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true, -- always show source
        header = "",
        prefix = "",
    },
    virtual_text = true, -- Show diagnostics inline with the code
    signs = true,        -- Show signs in the gutter
    underline = true,    -- Underline problematic code
    update_in_insert = false,
    severity_sort = true,
})

vim.cmd.colorscheme("onedark")
