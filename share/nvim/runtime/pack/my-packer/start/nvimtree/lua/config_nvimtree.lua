local sta, nvimtree = pcall(require, "nvim-tree")
if not sta then
  return
end

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC6FF ]])

nvimtree.setup({
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      resize_window = false,
      window_picker = {
        enable = false,
      },
    },
  },
  update_focused_file = {
    enable = false,
  },
  sort_by = "extension",
  view = {
    mappings = {
      custom_only = true,
      list = {
        { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
        { key = { "O", "<2-RightMouse>" },        action = "cd" },
        { key = "di",                             action = "vsplit" },
        { key = "do",                             action = "split" },
        { key = "dt",                             action = "tabnew" },
        { key = "<",                              action = "prev_sibling" },
        { key = ">",                              action = "next_sibling" },
        { key = "P",                              action = "parent_node" },
        { key = "<BS>",                           action = "close_node" },
        { key = "<Tab>",                          action = "preview" },
        { key = "K",                              action = "first_sibling" },
        { key = "J",                              action = "last_sibling" },
        { key = "I",                              action = "toggle_git_ignored" },
        { key = ".",                              action = "toggle_dotfiles" },
        { key = "U",                              action = "toggle_custom" },
        { key = "<F5>",                           action = "refresh" },
        { key = "a",                              action = "create" },
        { key = "D",                              action = "remove" },
        { key = "_D",                             action = "trash" },
        { key = "r",                              action = "rename" },
        { key = "<C-r>",                          action = "full_rename" },
        { key = "m",                              action = "cut" },
        { key = "cc",                             action = "copy" },
        { key = "p",                              action = "paste" },
        { key = "y",                              action = "copy_name" },
        { key = "Y",                              action = "copy_path" },
        { key = "gy",                             action = "copy_absolute_path" },
        { key = "[e",                             action = "prev_diag_item" },
        { key = "dk",                             action = "prev_git_item" },
        { key = "]e",                             action = "next_diag_item" },
        { key = "dj",                             action = "next_git_item" },
        { key = "h",                              action = "dir_up" },
        { key = "x",                              action = "system_open" },
        { key = "f",                              action = "live_filter" },
        { key = "F",                              action = "clear_live_filter" },
        { key = "q",                              action = "close" },
        { key = "W",                              action = "collapse_all" },
        { key = "E",                              action = "expand_all" },
        { key = "S",                              action = "search_node" },
        { key = "!",                              action = "run_file_command" },
        { key = "<C-g>",                          action = "toggle_file_info" },
        { key = "?",                              action = "toggle_help" },
        { key = "'",                              action = "toggle_mark" },
        { key = "M",                              action = "bulk_move" },
      },
    }
  },
})
