@ECHO off
GOTO start
:find_dp0
SET dp0=%~dp0
EXIT /b
:start
SETLOCAL
CALL :find_dp0

REM  endLocal & goto #_undefined_# 2>NUL || title %COMSPEC% & "D:\Desktop\neovim083_and_plugins\share\nvim\runtime\my-neovim-data\mason\packages\clangd\clangd\bin\clangd.exe" %*
endLocal & goto #_undefined_# 2>NUL || title %COMSPEC% & "C:\Users\llydr\Desktop\neovim083_and_plugins\share\nvim\runtime\my-neovim-data\mason\packages\clangd\clangd\bin\clangd.exe" %*
