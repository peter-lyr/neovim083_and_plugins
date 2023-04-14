local M = {}

local g = vim.g
local c = vim.cmd
local o = vim.opt

local Path = require("plenary.path")

local p6 = Path:new(g.markdownpreview_lua)
g.markdownpreview_dir = p6:parent():parent()['filename']
local p6 = Path:new(g.markdownpreview_dir)

g.mkdp_markdown_css = p6:joinpath('autoload', 'mkdp_markdown.css')['filename']

function M.do_markdownpreview(cmd)
  if o.ft:get() == 'markdown' then
    c(cmd)
  end
end

return M
