return {
  -- 'shaunsingh/nord.nvim',
  'folke/tokyonight.nvim',
  opts = {
    style = "night",
    transparent = true, 
  },
  lazy = false,
  priority = 1000,

  config = function(_, opts)
    -- Example config in Lua
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    -- Load the colorscheme
    require('tokyonight').setup(opts)
    vim.cmd([[colorscheme tokyonight]])

    ---------------------------------------------------------------------
    -- 🧩 TRANSPARENCY 
    ---------------------------------------------------------------------

    vim.g.transparent_enabled = true

    function _G.toggle_transparency()
      if vim.g.transparent_enabled then
        vim.cmd([[
          hi Normal guibg=NONE ctermbg=NONE
          hi NormalNC guibg=NONE ctermbg=NONE
          hi SignColumn guibg=NONE
          hi LineNr guibg=NONE
        ]])
      else
        vim.cmd([[
          hi Normal guibg=#0f0f0f
          hi NormalNC guibg=#0f0f0f
          hi SignColumn guibg=#0f0f0f
          hi LineNr guibg=#0f0f0f
        ]])
      end
      vim.g.transparent_enabled = not vim.g.transparent_enabled
    end
    vim.keymap.set('n', '<leader>tb', toggle_transparency, { noremap = true, silent = true })
    toggle_transparency()
  end,
}
