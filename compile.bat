@echo Started: %date% %time%
@echo off


pushd %~dp0

if %PROCESSOR_ARCHITECTURE% == AMD64 (
	CALL "%~dp0tools\tweeGo\tweego_win64.exe" -f "zuckerwuerfel" --head "%~dp0src\head.txt" -o "%~dp0index.html" "%~dp0src"
) else (
	CALL "%~dp0tools\tweeGo\tweego_win86.exe" -f "zuckerwuerfel" --head "%~dp0src\head.txt" -o "%~dp0index.html" "%~dp0src"
)


popd
@echo Completed: %date% %time%