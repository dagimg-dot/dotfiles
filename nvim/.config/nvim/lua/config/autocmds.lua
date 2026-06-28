-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("close_on_bdelete", { clear = true }),
  desc = "Close split when its buffer is deleted",
  callback = function()
    vim.schedule(function()
      if vim.fn.winnr("$") <= 1 then
        return
      end

      local buf = vim.api.nvim_get_current_buf()
      local win = vim.api.nvim_get_current_win()

      local all_others_are_sidebars = true
      for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        if win_id ~= win then
          local other_ft = vim.bo[vim.api.nvim_win_get_buf(win_id)].filetype
          if other_ft ~= "neo-tree" then
            all_others_are_sidebars = false
            break
          end
        end
      end

      if all_others_are_sidebars then
        return
      end

      if vim.fn.bufname(buf) == "" and not vim.bo[buf].modified then
        pcall(vim.api.nvim_win_close, win, true)
        return
      end

      for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        if win_id ~= win and vim.api.nvim_win_get_buf(win_id) == buf then
          pcall(vim.api.nvim_win_close, win, true)
          return
        end
      end
    end)
  end,
})
