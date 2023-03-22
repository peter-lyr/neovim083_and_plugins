local g = vim.g
local a = vim.api
local o = vim.opt
local s = vim.keymap.set

local bufenter = function()
  if o.ft:get() == 'lua' then
    s({'n', 'v'}, 'K', '<nop>', {buffer = true})
  elseif o.ft:get() == 'netrw' then
    if o.winfixwidth:get() then
      if not g.bufferenter_do_netrw then
        g.bufferenter_do_netrw = 1
        local sta, toggle_netrw = pcall(require, 'toggle_netrw')
        if not sta then
          print('no toggle_netrw')
          return
        end
      end
      if not toggle_netrw then
        return
      end
      toggle_netrw.netrw_fix_set_width()
    end
  end
end

a.nvim_create_autocmd({"BufEnter"}, {
  callback = bufenter,
})
