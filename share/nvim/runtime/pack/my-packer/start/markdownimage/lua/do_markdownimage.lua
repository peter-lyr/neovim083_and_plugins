local M = {}

local g = vim.g
local o = vim.opt
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

local human_readable_fsize = function(sz)
  if sz >= 1073741824 then
    sz = string.format("%.1f",sz/1073741824.0) .. "G"
  elseif sz >= 10485760 then
    sz = string.format("%d",sz/1048576) .. "M"
  elseif sz >= 1048576 then
    sz = string.format("%.1f",sz/1048576.0) .. "M"
  elseif sz >= 10240 then
    sz = string.format("%d",sz/1024) .. "K"
  elseif sz >= 1024 then
    sz = string.format("%.1f",sz/1024.0) .. "K"
  else
    sz= sz
  end
  return sz
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
    local linenr = f['line']('.')
    local ft = o.ft:get()
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
    timer:start(100, 100, function()
      vim.schedule(function()
        timeout = timeout + 1
        local file = io.open(image_path, "rb")
        if file then
          timer:stop()
          print('save one image:', image_path)
          local sha256 = require("sha2")
          local data = file:read("*all")
          file:close()
          local hash = sha256.sha256(data)
          local file = io.open(project_dir:joinpath('saved_images', '_.md')['filename'], 'a')
          local image_rel_path = image_name .. '.' .. imagetype
          local fsize = f['getfsize'](image_path)
          file:write(string.format('![%s-(%d)%s{%s}](%s)\n', image_rel_path, fsize, human_readable_fsize(fsize), hash, image_rel_path))
          file:close()
          if ft ~= 'markdown' then
            return
          end
          local image_reduce_path = image_path .. '.' .. imagetype
          os.execute(string.format('ffmpeg -y -loglevel quiet -i "%s" -q 18 %s', image_path, image_reduce_path))
          local sta, base64 = pcall(require, 'base64')
          if not sta then
            print('get image: no base64')
            return
          end
          local file = io.open(image_reduce_path, "rb")
          local content = file:read("*a")
          file:close()
          os.execute(string.format('del "%s"', image_reduce_path))
          local encoded = base64.encode(content)
          image_format = (imagetype == 'jpg') and 'jpeg' or 'png'
          f['append'](linenr, string.format('![%s](data:image/%s;base64,%s)', image_rel_path, image_format, encoded))
        end
        if timeout > 60 then
          print('get image timeout 6s')
          timer:stop()
        end
      end)
    end)
  end
end

return M
