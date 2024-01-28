

return {
  {
    "iamcco/markdown-preview.nvim",
    build = function ()
      vim.fn["mkdp#util#install"]()
    end,
    config = function ()
      vim.g["mkdp_auto_close"] = 1
      vim.g["mkdp_refresh_slow"] = 1

      vim.g["mkdp_browser"] = "firefox"
      vim.g["mkdp_markdown_css"] = vim.fn.expand("~/.config/nvim/package/node_modules/github-markdown-css/github-markdown-dark.css")

    end,
  }
}
