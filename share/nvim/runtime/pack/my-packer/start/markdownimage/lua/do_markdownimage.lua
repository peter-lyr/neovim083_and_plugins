local M = {}

local g = vim.g
local c = vim.cmd
local a = vim.api
local f = vim.fn

local Path = require("plenary.path")

local markdownimage_dir = Path:new(g.markdownimage_lua):parent():parent()['filename']
g.get_clipboard_image_ps1 = Path:new(markdownimage_dir):joinpath('autoload', 'GetClipboardImage.ps1')['filename']

local sta, do_terminal = pcall(require, 'do_terminal')
if not sta then
  print'no do_terminal in markdownimage'
end

function M.getimage(sel_jpg)
  if do_terminal then
    local datetime = os.date("%Y%m%d-%H%M%S-")
    local imagetype = sel_jpg == 1 and 'jpg' or 'png'
    local image_name = f['input'](string.format('Input %s image name (no extension needed!): ', imagetype), datetime)
    if #image_name == 0 then
      print('get image canceled!')
      return
    end
    local project_dir = Path:new(f['projectroot#get'](a['nvim_buf_get_name'](0)))
    local image_path = 'C:\\images'
    if project_dir:is_dir() then
      image_path = project_dir:joinpath('saved_images')['filename']
    end
    local image_path = Path:new(image_path)
    if not image_path:exists() then
      image_path:mkdir()
      print("created ->", image_path)
    end
    print("get image ->", image_path)
    local image_path = image_path:joinpath(image_name)['filename']
    cmd = string.format('%s "%s" %d', g.get_clipboard_image_ps1, image_path, sel_jpg)
    do_terminal.send_cmd('powershell', cmd, 0)
    local timer = vim.loop.new_timer()
    local timeout = 0
    local image_path = image_path .. '.' .. imagetype
    timer:start(1000, 1000, function()
      vim.schedule(function()
        timeout = timeout + 1
        local file = io.open(image_path, "r")
        if file then
          file:close()
          timer:stop()
        end
        if timeout > 6 then
          print('get image timeout 6s')
          timer:stop()
        end
      end)
    end)
  end
end

return M
