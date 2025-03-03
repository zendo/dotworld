set myDIR=%APPDATA%\.emacs.d
IF not exist %myDIR% (mkdir %myDIR%)

mklink /H %APPDATA%\.emacs.d\init.org %HOMEPATH%\nsworld\dotfiles\emacs\init.org
mklink /H %APPDATA%\.emacs.d\early-init.el %HOMEPATH%\nsworld\dotfiles\emacs\early-init.el

mklink /J %APPDATA%\.doom.d %HOMEPATH%\nsworld\dotfiles\doom
