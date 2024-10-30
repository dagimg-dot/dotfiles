return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "right",
      width = 26,
      mappings = {
        ["<leader>j"] = "focus_preview",
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
          ".DS_Store",
        },
        always_show = {
          ".env",
        },
      },
    },
  },
}
