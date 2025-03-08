@echo off
echo Starting...

setx HOME %USERPROFILE%

set myDIR=%USERPROFILE%\.emacs.d
IF not exist %myDIR% (mkdir %myDIR%)

mklink /H %USERPROFILE%\.emacs.d\all-emacs.org %HOMEPATH%\nsworld\dotfiles\org\all-emacs.org
mklink /J %USERPROFILE%\.doom.d %HOMEPATH%\nsworld\dotfiles\doom

REM https://github.com/badrelmers/RefrEnv
REM curl -O https://raw.githubusercontent.com/badrelmers/RefrEnv/refs/heads/main/refrenv.bat
REM iwr "https://raw.githubusercontent.com/badrelmers/RefrEnv/refs/heads/main/refrenv.bat" -O refrenv.bat
call "%~dp0refrenv.bat"
timeout /t 2 /nobreak >nul
emacs --batch -l org --eval "(setq vc-follow-symlinks nil)" --eval "(org-babel-tangle-file \"~/.emacs.d/all-emacs.org\")"

echo Done!
pause
exit
