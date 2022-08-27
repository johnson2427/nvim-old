require("blake.set")
require("blake.packer")
require("blake.neogit")
require("blake.debugger")
require("blake.rtp")
require("blake.null-ls")

local augroup = vim.api.nvim_create_augroup
blakeGroup = augroup("blake", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufEnter", "BufWinEnter", "TabEnter"}, {
    group = blakeGroup,
    pattern = "*.py",
    callback = function()
        require("lsp_extensions").inlay_hints{}
    end
})

autocmd({"BufWritePre"}, {
    group = blakeGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

