return {
  "stevearc/vim-arduino",
  ft = { "arduino", "ino" },
  config = function()
    -- Ensure .ino files are treated as arduino (C++)
    vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
      pattern = {"*.ino"},
      callback = function() vim.bo.filetype = "ino" end
    })
  end,
},
-- Treat .ino as C++ for syntax highlighting and LSP
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ino",
  callback = function()
    vim.bo.filetype = "cpp"
  end,
})
