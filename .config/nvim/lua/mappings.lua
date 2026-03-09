require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Run current file
local runners = {
  python = "python3 %",
  cpp = "g++ % -o %:r && ./%:r",
  java = "javac % && java %:r",
  javascript = "node %",
  html = "xdg-open %",
  css = "xdg-open %",
  scss = "xdg-open %",
}

map("n", "<leader>r", function()
  local ft = vim.bo.filetype
  local cmd = runners[ft]
  if cmd then
    vim.cmd("w")
    vim.cmd("botright split | resize 10 | term " .. cmd)
  else
    vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
  end
end, { desc = "Save and Run file" })


-- Autocomplete navigation
map("i", "<C-Up>", "<C-p>", { desc = "Prev completion item" })
map("i", "<C-Down>", "<C-n>", { desc = "Next completion item" })
