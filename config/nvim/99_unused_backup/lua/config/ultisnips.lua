if vim.fn.has("python3") == 1 then
    vim.g.UltiSnipsExpandTrigger = "<Tab>";
    vim.g.UltiSnipsJumpForwardTrigger = "<Tab>";
    vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>";
    vim.g.UltiSnipsEditSplit = "vertical";
    vim.g.UltiSnipsSnippetsDir = '~/.vim/UltiSnips';
end
