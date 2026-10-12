return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        custom_filter = function(buf)
          return vim.fn.bufname(buf) ~= ""
        end,
      },
    },
  },
}
