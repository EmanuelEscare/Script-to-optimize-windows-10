@echo off

SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

@REM Set green color for characters
color 2
echo ================================================================================
echo ^|^|          _ _,---._                                                         ^|^|
echo ^|^|       ,-','       `-.___                                                   ^|^|
echo ^|^|      ^/-;'               `._                                                ^|^|
echo ^|^|     ^/^\ ^/          ._   _,'o ^\                                              ^|^|
echo ^|^|    ( ^/^\       _,--'^\,','"`. )                                              ||
echo ^|^|     ^|^\      ,'o     ^\'    ^/ ^/^\                                             ^|^|
echo ^|^|     ^|      ^\        ^/   ,--'""`-.                                          ^|^|
echo ^|^|     :       ^\_    _ ^/ ,-'         `-._                                     ^|^|
echo ^|^|      ^\        `--'  ^/                )                                     ^|^|
echo ^|^|       `.  ^\`._    ,'     ________,','                                      ^|^|
echo ^|^|         .--`     ,'  ,--` __^\___,;'                                        ^|^|
echo ^|^|          ^\`.,-- ,' ,`_)--'  ^/`.,'                                          ^|^|
echo ^|^|           ^\( ;  ^| ^| )      (`- ^/                                           ^|^|
echo ^|^|             `--'^| ^|)       ^|- ^/                                            ^|^|
echo ^|^|               ^| ^| ^|        ^| ^|                                             ^|^|
echo ^|^|               ^| ^| ^|,.,-.   ^| ^|_                                            ^|^|
echo ^|^|               ^| `. ^/ ^/   )---`  )                                          ^|^|
echo ^|^|              _^|  ^/    ,',   ,-'                                            ^|^|
echo ^|^|             ,'^|_(    ^/-^<._,' ^|--,                                          ^|^|
echo ^|^|             ^|    `--'---.     ^\ ^/ ^\                                        ^|^|
echo ^|^|             ^|          ^/ ^\    ^/^\  ^\                                        ^|^|
echo ^|^|           ,-^---._     ^|  ^\  ^/  ^\  ^\                                        ^|^|
echo ^|^|        ,-'        ^\----'   ^\ ^/    ^\--`.                                    ^|^|
echo ^|^|       ^/            ^\              ^\   ^\                                    ^|^|
echo ^|^|  ______                                  _   ______                        ^|^|          
echo ^|^| ^|  ____^|                                ^| ^| ^|  ____^|                       ^|^|         
echo ^|^| ^| ^|__   _ __ ___   __ _ _ __  _   _  ___^| ^| ^| ^|__   ___  ___               ^|^|
echo ^|^| ^|  __^| ^| '_ ` _ ^\ ^/ _` ^| '_ ^\^| ^| ^| ^|^/ _ ^| ^| ^|  __^| ^/ __^|^/ __^|              ^|^|
echo ^|^| ^| ^|____^| ^| ^| ^| ^| ^| (_^| ^| ^| ^| ^| ^|_^| ^|  __^| ^| ^| ^|____^\__ ^| (__               ^|^|
echo ^|^| ^|______^|_^| ^|_^| ^|_^|^\__,_^|_^| ^|_^|^\__,_^|^\___^|_^| ^|______^|___^/^\___^|              ^|^|
echo ^|^|==============================================================================
echo ^|^|   _____    _____   _____    _    _              ______    _____    ____    ^|^|
echo ^|^|  ^/ ____^|  ^/ ____^| ^|  __ ^\  ^| ^|  ^| ^|     ^/^\     ^|  ____^|  ^/ ____^|  ^/ __ ^\   ^|^|
echo ^|^| ^| (___   ^| (___   ^| ^|__) ^| ^| ^|  ^| ^|    ^/  ^\    ^| ^|__    ^| (___   ^| ^|  ^| ^|  ^|^|
echo ^|^|  ^\___ ^\   ^\___ ^\  ^|  ___^/  ^| ^|  ^| ^|   ^/ ^/^\ ^\   ^|  __^|    ^\___ ^\  ^| ^|  ^| ^|  ^|^|
echo ^|^|  ____) ^|  ____) ^| ^| ^|      ^| ^|__^| ^|  ^/ ____ ^\  ^| ^|____   ____) ^| ^| ^|__^| ^|  ^|^|
echo ^|^| ^|_____^/  ^|_____^/  ^|_^|       ^\____^/  ^/_^/    ^\_^\ ^|______^| ^|_____^/   ^\____^/   ^|^|
echo ================================================================================

@REM Pause to view the sign
timeout /t 3 /nobreak >nul

cls

@REM List of processes that should not be eliminated
set process_no_taskkill="TiWorker.exe" "TrustedInstaller.exe" "System Idle Process" "System" "Registry" "smss.exe" "csrss.exe" "wininit.exe" "services.exe" "lsass.exe" "svchost.exe" "explorer.exe" "RuntimeBroker.exe" "NVDisplay.Container.exe" "NVIDIA Web Helper.exe" "nvcontainer.exe" "NVIDIA" "AMDRSServ.exe" "CCC.exe" "RadeonSettings.exe" "amddvr.exe" "AMD User Experience Program" "amdkmdag.exe" "amdkmdap.exe" "tasklist.exe" "python3.9.exe" "RuntimeBroker.exe" "conhost.exe" "taskhost.exe" "spoolsv.exe" "dwm.exe" "winlogon.exe" "Memory Compression" "sihost.exe" "audiodg.exe" "SearchIndexer.exe" "MsMpEng.exe" "Code.exe" "Taskmgr.exe" "cmd.exe" "dllhost.exe" "SgrmBroker.exe" "powershell.exe" "fontdrvhost.exe" "OfficeClickToRun.exe" "SecurityHealthSystray.exe" "SecurityHealthService.exe" "TextInputHost.exe" "WmiPrvSE.exe" "LockApp.exe" "smartscreen.exe"

@REM The "tasklist" command is executed to obtain the list of processes in csv format
for /f "tokens=1 delims=," %%a in ('tasklist /fo csv ^| findstr /r /v "^$"') do (
    set "delete=true"
    @REM Compares the current value of A (the name of the process in the list of running processes) with the current value of B
    for %%b in (%process_no_taskkill%) do (
        if "%%a"=="%%b" (
            set "delete=false"
        )
    )
    @REM If it does not match any task, it is eliminated with the taskkill command
    if "!delete!"=="true" (

        taskkill /F /IM "%%a"
    )
)

cls

@REM Delete temporal files

del /q/f/s %TEMP%\*

cls
@REM Determines the virtual memory to be allocated
Set "totalMemory=0"
for /f "skip=1 tokens=1" %%a in ('wmic memorychip get capacity') do (
        REM Make the GET request and save the response in a variable
        for /f %%i in ('curl -s https://zysac.com/api/getbytes/%%a') do (
            SET "var="&for /f "delims=0123456789" %%o in ("%%i") do set var=%%o
            if defined var (cls) else (
                if %%i GTR 500 (
                    @REM Add the bytes of each RAM memory
                    set /a totalMemory=%%i + totalMemory
                    )
                )
        )
)
set /a totalMemoryGB=totalMemory / 1073741
echo El sistema cuenta con !totalMemoryGB! GB de RAM
timeout /t 3 /nobreak >nul
cls

set /a VMemoryMax=totalMemoryGB * 1024
set /a VMemoryMin=totalMemoryGB * 512

wmic computersystem where name=”%computername%” set AutomaticManagedPagefile=False

wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%VMemoryMin%,MaximumSize=%VMemoryMax%

echo Memoria Virtual Actualizada
echo MIN: !VMemoryMin! MAX: !VMemoryMax!
timeout /t 3 /nobreak >nul

echo Finalizo la optimizacion del sistema

timeout /t 3 /nobreak >nul
