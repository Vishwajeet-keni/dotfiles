return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        mode = "term", -- use a terminal instead of float
        focus = true,

        term = {
          position = "bot", -- bottom split
          size = 4,        -- height of terminal window
        },

        -- Commands for filetypes
        filetype = {
          python = "python3 -u",
          c = "gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt; read",
          cpp = "g++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt; read",
          java = "javac $fileName && java $fileNameWithoutExt; read",
          javascript = "node $fileName",
          typescript = "ts-node $fileName",
          sh = "bash $fileName; read",
          lua = "lua $fileName",
          html = "brave $fileName",
          css = "echo 'CSS cannot be executed'; read",
          yuck = "ech 'Yuck cannot be executed'; read",
        },
      })

      -- Run current file with <Space>r
      vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { desc = "Run current file" })
    end,
  },
}
