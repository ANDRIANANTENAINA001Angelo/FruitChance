@echo off
SET SCRIPT_DIR=%~dp0

dart compile exe "%SCRIPT_DIR%game\console.dart" -o "%SCRIPT_DIR%build\fruit-chance-console.exe"

echo ✅ Compilation terminée !
pause
