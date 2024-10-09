return {
  'AlexvZyl/nordic.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local palette = require 'nordic.colors'
    require('nordic').setup {
      -- This callback can be used to override the colors used in the palette.
      on_palette = function(pal)
        pal.black0 = '#282a2e'
        pal.cyan.base = '#5e8d87'
        return pal
      end,
      -- Enable bold keywords.
      bold_keywords = true,
      -- Enable italic comments.
      italic_comments = true,
      -- Enable general editor background transparency.
      transparent = {
        bg = true,
        float = false
      },
      -- Enable brighter float border.
      bright_border = true,
      -- Reduce the overall amount of blue in the theme (diverges from base Nord).
      reduced_blue = true,
      -- Swap the dark background with the normal one.
      swap_backgrounds = false,
      -- Override the styling of any highlight group.
      override = {
        Visual = {
          bg = palette.grey3,
        },
        Pmenu = {
          bg = palette.black0,
        },
        PmenuSel = {
          bg = palette.gray5,
        },
        TelescopeBorder = {
          fg = palette.black2,
          bg = palette.green.bright,
        },
        CmpSel = {
          fg = palette.black2,
          bg = palette.green.bright,
          italic = false,
          bold = true,
          underline = false,
          sp = palette.yellow.dim,
          undercurl = false,
        },
        LspReferenceText = {
          bg = palette.gray1,
        },
        LspReferenceWrite = {
          bg = palette.gray1,
        },
        LspReferenceRead = {
          bg = palette.gray1,
        },
      },
      -- Cursorline options.  Also includes visual/selection.
      cursorline = {
        -- Bold font in cursorline.
        bold = false,
        -- Bold cursorline number.
        bold_number = true,
        -- Available styles: 'dark', 'light'.
        theme = 'dark',
        -- Blending the cursorline bg with the buffer bg.
        blend = 0.85,
      },
      noice = {
        -- Available styles: `classic`, `flat`.
        style = 'classic',
      },
      telescope = {
        -- Available styles: `classic`, `flat`.
        style = 'classic',
      },
      leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false,
      },
      ts_context = {
        -- Enables dark background for treesitter-context window
        dark_background = true,
      },
    }
    require('nordic').load()
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.fileScope', { fg = palette.gray5 })
    vim.api.nvim_set_hl(0, '@lsp.type.namespace', { italic = true })
  end,
}
