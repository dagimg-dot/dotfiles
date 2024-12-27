return {
  "olivercederborg/poimandres.nvim", -- Poimandres theme plugin
  config = function()
    -- Customize the theme here
    require("poimandres").setup({
      bold_vert_split = false, -- Example customization
      dim_nc_background = true, -- Dimming inactive windows
      disable_background = true, -- Use background color
      disable_float_background = false,
      disable_italics = true, -- Disable italics if you want
    })

    vim.cmd([[colorscheme poimandres]])
  end,
}
