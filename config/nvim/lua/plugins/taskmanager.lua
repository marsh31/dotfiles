return {
  {
    enabled = false,
    "arnarg/todotxt.nvim",
    config = function()
      require("todotxt-nvim").setup({
        todo_file = vim.fn.expand("~/til/tm/action.todo.txt"),
      })

      vim.filetype.add({
        filename = {
          ["~/til/tm/action.todo.txt"] = "todotxt",
          ["~/til/tm/action.done.txt"] = "todotxt",
          ["~/til/tm/report.txt"] = "todotxt",
        },
      })
    end,
  },

  {
    "freitass/todo.txt-vim",
    config = function ()
    end
  },
}
