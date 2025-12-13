return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()

      -- Keymap: toggle comment using <Space>/
      vim.keymap.set({ "n", "v" }, "<Space>/", function()
        require("Comment.api").toggle.linewise.current()
      end, { desc = "Toggle comment" })
    end,
  },
}
