@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"C:\Users\emachnic\GitRepos\railsinstaller-windows\stage\Ruby2.2.0\bin\ruby.exe" "C:/Users/emachnic/GitRepos/railsinstaller-windows/stage/Ruby2.2.0/bin/tilt" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"C:\Users\emachnic\GitRepos\railsinstaller-windows\stage\Ruby2.2.0\bin\ruby.exe" "%~dpn0" %*