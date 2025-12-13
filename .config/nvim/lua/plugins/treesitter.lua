return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
    ensure_installed = {'lua','vim','vimdoc','bash','json','jsonc',
                        'yaml','toml','make','cmake','gitignore', --Core
                        'python','javascript','typescript','tsx','go',
                        'java','html','css', 'scss',              --Programing & Web/UI
                        'sql','dockerfile','terraform',           --DevOps/Infra/Backend
                        'markdown','markdown_inline',             --documentation & Data
                        'groovy','graphql','yuck',                 --Additional
                        },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
}
