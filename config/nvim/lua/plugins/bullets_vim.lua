return {
    {
        "bullets-vim/bullets.vim",
        ft = { "markdown", "text", "gitcommit" },
        cond = false,
        init = function()
            vim.g["bullets_set_mappings"] = 0

            vim.g["bullets_custom_mappings"] = {
                { "imap", "<M-cr>",    "<Plug>(bullets-newline)"         },
                { "imap", "<C-cr>",    "<Plug>(bullets-newline)"         },

                { "vmap", "gN",        "<Plug>(bullets-renumber)"        },
                { "nmap", "gN",        "<Plug>(bullets-renumber)"        },

                { "imap", "<C-t>",     "<Plug>(bullets-demote)"          },
                { "nmap", ">>",        "<Plug>(bullets-demote)"          },
                { "vmap", ">",         "<Plug>(bullets-demote)"          },

                { "imap", "<C-d>",     "<Plug>(bullets-promote)"         },
                { "nmap", ">>",        "<Plug>(bullets-promote)"         },
                { "vmap", ">",         "<Plug>(bullets-promote)"         },

                { "nmap", "<leader>x", "<Plug>(bullets-toggle-checkbox)" },
            }

            vim.g["bullets_outline_levels"] = {
                "std-",
                "std*",
                "std+",
            }
        end,
    },
}
