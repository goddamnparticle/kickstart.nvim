return {
  'fasterius/simple-zoom.nvim',
  keys = {
    {
      '<leader>z',
      function()
        require('simple-zoom').toggle_zoom()
      end,
      desc = 'Zoom current window',
    },
  },
}
