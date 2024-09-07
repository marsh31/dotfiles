return {
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        ft = "markdown",
        opts = {
            markdown = {
                query = vim.treesitter.query.parse(
                    "markdown",
                    [[
                        (atx_heading [
                            (atx_h1_marker)
                            (atx_h2_marker)
                            (atx_h3_marker)
                            (atx_h4_marker)
                            (atx_h5_marker)
                            (atx_h6_marker)
                        ] @headline)

                        (thematic_break) @dash

                        (fenced_code_block) @codeblock

                        (block_quote_marker) @quote
                        (block_quote (paragraph (inline (block_continuation) @quote)))
                        (block_quote (paragraph (block_continuation) @quote))
                        (block_quote (block_continuation) @quote)
                    ]]
                ),
                headline_highlights = { "Headline" },
                bullet_highlights = {
                    "@text.title.1.marker.markdown",
                    "@text.title.2.marker.markdown",
                    "@text.title.3.marker.markdown",
                    "@text.title.4.marker.markdown",
                    "@text.title.5.marker.markdown",
                    "@text.title.6.marker.markdown",
                },
                bullets = { "◉", "○", "✸", "✿" },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "-",
                quote_highlight = "Quote",
                quote_string = "┃",
                fat_headlines = true,
                fat_headline_upper_string = "▃",
                fat_headline_lower_string = "🬂",
            },
        },
    },
    {
        "jakewvincent/mkdnflow.nvim",
        ft = "markdown",
        config = function()
            require("mkdnflow").setup({
                modules = {
                    bib = false,
                    buffers = true,
                    conceal = true,
                    cursor = true,
                    folds = true,
                    links = true,
                    lists = true,
                    maps = true,
                    paths = true,
                    tables = true,
                    yaml = false,
                    cmp = false,
                },
                filetypes = { md = true, rmd = true, markdown = true },
                create_dirs = true,
                perspective = {
                    priority = "first",
                    fallback = "current",
                    root_tell = false,
                    nvim_wd_heel = false,
                    update = true,
                },
                wrap = false,
                bib = {
                    default_path = nil,
                    find_in_root = true,
                },
                silent = false,
                cursor = {
                    jump_patterns = nil,
                },
                links = {
                    style = "markdown",
                    conceal = false,
                    context = 0,
                    implicit_extension = nil,
                    transform_implicit = false,
                    transform_explicit = function(text)
                        text = text:gsub(" ", "-")
                        text = text:lower()
                        text = os.date("%Y-%m-%d_") .. text
                        return text
                    end,
                },
                new_file_template = {
                    use_template = false,
                    placeholders = {
                        before = {
                            title = "link_title",
                            date = "os_date",
                        },
                        after = {},
                    },
                    template = "# {{ title }}",
                },
                to_do = {
                    symbols = { " ", "-", "X" },
                    update_parents = true,
                    not_started = " ",
                    in_progress = "-",
                    complete = "X",
                },
                tables = {
                    trim_whitespace = true,
                    format_on_move = true,
                    auto_extend_rows = false,
                    auto_extend_cols = false,
                    style = {
                        cell_padding = 1,
                        separator_padding = 1,
                        outer_pipes = true,
                        mimic_alignment = true,
                    },
                },
                yaml = {
                    bib = { override = false },
                },
                mappings = {
                    MkdnEnter = { { "n", "v", "i" }, "<CR>" },
                    MkdnTab = false,
                    MkdnSTab = false,
                    MkdnNextLink = { "n", "<Tab>" },
                    MkdnPrevLink = { "n", "<S-Tab>" },
                    MkdnNextHeading = { "n", "]]" },
                    MkdnPrevHeading = { "n", "[[" },
                    MkdnGoBack = { "n", "<BS>" },
                    MkdnGoForward = { "n", "<Del>" },
                    MkdnCreateLink = false, -- see MkdnEnter
                    MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>p" }, -- see MkdnEnter
                    MkdnFollowLink = false, -- see MkdnEnter
                    MkdnDestroyLink = { "n", "<M-CR>" },
                    MkdnTagSpan = { "v", "<M-CR>" },
                    MkdnMoveSource = { "n", "<F2>" },
                    MkdnYankAnchorLink = { "n", "yaa" },
                    MkdnYankFileAnchorLink = { "n", "yfa" },
                    MkdnIncreaseHeading = { "n", "+" },
                    MkdnDecreaseHeading = { "n", "-" },
                    MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
                    MkdnNewListItem = false,
                    MkdnNewListItemBelowInsert = { "n", "o" },
                    MkdnNewListItemAboveInsert = { "n", "O" },
                    MkdnExtendList = false,
                    MkdnUpdateNumbering = { "n", "<leader>nn" },
                    MkdnTableNextCell = { "i", "<Tab>" },
                    MkdnTablePrevCell = { "i", "<S-Tab>" },
                    MkdnTableNextRow = false,
                    MkdnTablePrevRow = { "i", "<M-CR>" },
                    MkdnTableNewRowBelow = { "n", "<leader>ir" },
                    MkdnTableNewRowAbove = { "n", "<leader>iR" },
                    MkdnTableNewColAfter = { "n", "<leader>ic" },
                    MkdnTableNewColBefore = { "n", "<leader>iC" },
                    MkdnFoldSection = { "n", "<leader>f" },
                    MkdnUnfoldSection = { "n", "<leader>F" },
                },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.g["mkdp_auto_close"] = 1
            vim.g["mkdp_refresh_slow"] = 1

            vim.g["mkdp_browser"] = "firefox"
            vim.g["mkdp_markdown_css"] =
                vim.fn.expand("~/.config/nvim/package/node_modules/github-markdown-css/github-markdown-dark.css")
        end,
    },
}

-- vim: set sw=4
