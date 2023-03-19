@echo off
echo ------------------------------------
echo %~0
echo %cd%
echo ------------------------------------
set res=
for /f "delims=" %%t in ('git status -s') do (
  set res=%res%%%t
)
if defined res (
  git status
  echo ------------------------------------
) else (
  timeout /t 3
  exit /b
)
set var=
set /p var=commit info (Just push): 
if not defined var (
  timeout /t 3
  exit /b
)
set var2=
set /p var2=Sure to just push? (Empty for yes): 
if not defined var2 (
  git commit -m "%var%"
  git push
)
timeout /t 3
