local c = vim.cmd
local s = vim.keymap.set


local coderunner_exe = function(cmd)
  if not vim.g.loaded_config_coderunner then
    vim.g.loaded_config_coderunner = 1
    sta, config_coderunner = pcall(require, 'code_runner')
    if not sta then
      print('no config_coderunner')
      return
    end
    config_coderunner.setup({
      filetype = {
        python = "python -u",
        c = "cd $dir && gcc $fileName -Wall -O3 -o $fileNameWithoutExt && strip -s $dir/$fileNameWithoutExt.exe && upx -9 $dir/$fileNameWithoutExt.exe && $dir/$fileNameWithoutExt"
      },
    })
  end
  if not config_coderunner then
    return
  end
  c'RunCode'
end


s({'n', 'v'}, '<leader>rr', function() coderunner_exe("") end, {silent = true})
