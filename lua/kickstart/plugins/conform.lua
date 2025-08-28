vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_fallback = true, range = range }
end, { range = true })

return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true, cc = true, hh = true }
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --   }
    -- end,
    formatters_by_ft = {
      sh = { 'shellcheck', 'beautysh' },
      lua = { 'cstylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { 'prettierd' },
      -- c formatter
      c = { 'clang_format' },
      -- c++ formatter
      cpp = { 'clang_format' },
      cuda = { 'clang_format' },
      -- cmake formatter
      -- cmake = { 'neocmake' },
      cmake = { 'cmake_format' },
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
    },
    formatters = {
      -- neocmake = {
      --   command = vim.fn.stdpath 'data' .. '/mason/bin/neocmakelsp',
      --   args = { '-F', '$FILENAME' },
      --   stdin = true,
      -- },
      cstylua = {
        meta = {
          url = 'https://github.com/JohnnyMorganz/StyLua',
          description = 'An opinionated code formatter for Lua.',
        },
        command = 'stylua',
        args = { '--indent-width', '2', '--search-parent-directories', '--stdin-filepath', '$FILENAME', '-' },
      },
    },
  },
}
