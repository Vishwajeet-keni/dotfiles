require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.ino",
  callback = function()
    local lines = {
      "void setup() {",
      "  // setup code here, runs once",
      "",
      "}",
      "",
      "void loop() {",
      "  // main code here, runs repeatedly",
      "",
      "}",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.cmd("w")
  end,
})
