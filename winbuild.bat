set PATH=%PATH%;C:\Qt\5.2.0\mingw48_32\bin
set PATH=%PATH%;C:\Qt\Tools\mingw48_32\bin

:: Delete old dist dir; the last thing we need is partial builds
del /Q dist
mkdir dist

:: Build the tool
cd tool
qmake
mingw32-make release
xcopy release\KanColleTool.exe ..\dist
mingw32-make clean
rmdir /s /q debug
rmdir /s /q release
cd ..

:: Build the viewer
cd viewer
qmake
mingw32-make release
xcopy release\KCTViewer.exe ..\dist
mingw32-make clean
rmdir /s /q debug
rmdir /s /q release
cd ..

:: Copy MinGW32 DLLs that Qt doesn't catch automatically
xcopy C:\Qt\5.2.0\mingw48_32\bin\libgcc_s_dw2-1.dll dist
xcopy C:\Qt\5.2.0\mingw48_32\bin\libstdc++-6.dll dist
xcopy C:\Qt\5.2.0\mingw48_32\bin\libwinpthread-1.dll dist

:: Let Qt collect DLLs
windeployqt --no-translations dist\KCTViewer.exe
windeployqt --no-translations dist\KanColleTool.exe

:: Delete things we don't need at all
rmdir /s /q dist\playlistformats
rmdir /s /q dist\printsupport
rmdir /s /q dist\qmltooling
rmdir /s /q dist\sqldrivers

:: Delete debug versions of frameworks
del /q dist\accessible\*d.dll
del /q dist\bearer\*d.dll
del /q dist\iconengines\*d.dll
del /q dist\imageformats\*d.dll
del /q dist\mediaservice\*d.dll
del /q dist\platforms\*d.dll

::pause