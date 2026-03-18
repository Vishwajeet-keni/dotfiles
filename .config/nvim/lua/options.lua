require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.filetype.add({
  extension = {
    ino = "cpp",
    yuck = "lisp",
  }
})
