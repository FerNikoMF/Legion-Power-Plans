@echo off
chcp 65001 
setlocal
set "params=%*"
cd /d "%~dp0"

:: Проверка на права администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ----------------------------------------------------------------------
    echo Этот скрипт должен быть запущен с правами администратора.
    echo Please run this script as an administrator.
    echo ----------------------------------------------------------------------
    echo.
    powershell -Command "Start-Process -FilePath '%~dp0%~n0.bat' -Verb runas -ArgumentList '%params%'"
    exit /b
)

:language_menu
cls
echo.
echo ====================================================================
echo   Выберите язык / Choose your language:
echo ====================================================================
echo.
echo   [1] Русский
echo   [2] English
echo.
set /p lang_choice="Ваш выбор / Your choice: "

if "%lang_choice%"=="1" goto main_menu_ru
if "%lang_choice%"=="2" goto main_menu_en

echo.
echo Неверный выбор. Пожалуйста, выберите 1 или 2. / Invalid choice. Please select 1 or 2.
pause
goto language_menu

:main_menu_ru
cls
echo.
echo ====================================================================
echo   Выберите пакет планов питания для установки:
echo ====================================================================
echo.
echo   [1] Установить модифицированные планы питания (Modify)
echo   [2] Установить стоковые планы питания Lenovo (Stock Legion)
echo   [3] Выход
echo.
set /p choice="Ваш выбор: "

if "%choice%"=="1" goto install_modify
if "%choice%"=="2" goto install_stock
if "%choice%"=="3" goto end

echo.
echo Неверный выбор. Пожалуйста, выберите 1, 2 или 3.
pause
goto main_menu_ru

:main_menu_en
cls
echo.
echo ====================================================================
echo   Select power plan package to install:
echo ====================================================================
echo.
echo   [1] Install Modified Power Plans (Modify)
echo   [2] Install Stock Lenovo Power Plans (Stock Legion)
echo   [3] Exit
echo.
set /p choice="Your choice: "

if "%choice%"=="1" goto install_modify
if "%choice%"=="2" goto install_stock
if "%choice%"=="3" goto end

echo.
echo Invalid choice. Please select 1, 2, or 3.
pause
goto main_menu_en


:install_modify
cls
if "%lang_choice%"=="1" (
    echo ====================================================================
    echo   Выбраны модифицированные планы питания. Начинаю установку...
    echo ====================================================================
) else (
    echo ====================================================================
    echo   Modified power plans selected. Starting installation...
    echo ====================================================================
)
echo.
call :install_common "Modify"
goto end_message

:install_stock
cls
if "%lang_choice%"=="1" (
    echo ====================================================================
    echo   Выбраны стоковые планы питания Lenovo. Начинаю установку...
    echo ====================================================================
) else (
    echo ====================================================================
    echo   Stock Lenovo power plans selected. Starting installation...
    echo ====================================================================
)
echo.
call :install_common "Stock Legion"
goto end_message

:install_common
set "target_folder=%~1"

:: Импорт файла реестра
if "%lang_choice%"=="1" (
    echo [+] Импорт файла реестра PowerPlanOptions.reg...
) else (
    echo [+] Importing registry file PowerPlanOptions.reg...
)
reg import "PowerPlanOptions.reg"
if %errorLevel% equ 0 (
    if "%lang_choice%"=="1" (
        echo [+] Файл реестра успешно импортирован.
    ) else (
        echo [+] Registry file imported successfully.
    )
) else (
    if "%lang_choice%"=="1" (
        echo [!] Ошибка при импорте файла реестра. Скрипт остановлен.
        pause
    ) else (
        echo [!] Error importing registry file. Script stopped.
        pause
    )
    exit /b
)
echo.

:: Импорт планов питания из выбранной папки
if "%lang_choice%"=="1" (
    echo [+] Импорт планов питания из папки "%target_folder%"...
) else (
    echo [+] Importing power plans from folder "%target_folder%"...
)
for %%f in ("%target_folder%\*.pow") do (
    if "%lang_choice%"=="1" (
        echo   -> Импорт "%%~nf"...
    ) else (
        echo   -> Importing "%%~nf"...
    )
    powercfg -import "%%f"
    if %errorLevel% equ 0 (
        if "%lang_choice%"=="1" (
            echo   [+] План "%%~nf" успешно импортирован.
        ) else (
            echo   [+] Plan "%%~nf" imported successfully.
        )
    ) else (
        if "%lang_choice%"=="1" (
            echo   [!] Ошибка при импорте плана "%%~nf".
        ) else (
            echo   [!] Error importing plan "%%~nf".
        )
    )
)
echo.
exit /b

:end_message
if "%lang_choice%"=="1" (
    echo ====================================================================
    echo Установка завершена!
    echo Теперь вы можете выбрать новый план питания в настройках Windows.
    echo ====================================================================
) else (
    echo ====================================================================
    echo Installation complete!
    echo You can now select the new power plan in your Windows settings.
    echo ====================================================================
)
pause
goto end

:end
if "%lang_choice%"=="1" (
    echo.
    echo Установка отменена. Выход...
    echo.
) else (
    echo.
    echo Installation canceled. Exiting...
    echo.
)
pause