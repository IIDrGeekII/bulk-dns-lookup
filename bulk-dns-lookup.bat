@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ==========================
:: ASCII Banner
:: ==========================
echo  _           _ _             _                 _             _                
echo ^| ^|__  _   _^| ^| ^| __      __^| ^|_ __  ___      ^| ^| ___   ___ ^| ^| ___   _ _ __  
echo ^| ^'_ ^\^| ^| ^| ^| ^| ^|^/ ^/____ ^/ _^` ^| ^'_ ^\^/ __^|_____^| ^|^/ _ ^\ ^/ _ ^\^| ^|^/ ^/ ^| ^| ^| ^'_ ^\ 
echo ^| ^|_^) ^| ^|_^| ^| ^|   ^<_____^| ^(_^| ^| ^| ^| ^\__ ^\_____^| ^| ^(_^) ^| ^(_^) ^|   ^<^| ^|_^| ^| ^|_^) ^|
echo ^|_^.__^/ ^\__^,_^|_^|_^|^\_^\     ^\__^,_^|_^| ^|_^|___^/     ^|_^|^\___^/ ^\___^/^|_^|^\_^\^\__^,_^|^ ^.__^/ 
echo                                                                        ^|_^|    
echo.
echo +---------------------------------------+
echo ^| Author: @Vaibhav_Masane A.K.A @DrGeek ^|
echo +---------------------------------------+
echo.
:: ==========================

:: Work from script folder
cd /d "%~dp0"

:: Build a 40-space string used for padding
set "SP="
for /L %%i in (1,1,40) do set "SP=!SP! "

:: Input file
set /p "filename=Enter the filename containing URLs: "
if not exist "%filename%" (
  echo File "%filename%" not found!
  exit /b 1
)

:: Generate timestamp (YYYY-MM-DD_HHMM format)
for /f "tokens=2 delims==" %%a in ('"wmic os get localdatetime /value"') do set ldt=%%a
set "YYYY=!ldt:~0,4!"
set "MM=!ldt:~4,2!"
set "DD=!ldt:~6,2!"
set "HH=!ldt:~8,2!"
set "Min=!ldt:~10,2!"
set "timestamp=!YYYY!-!MM!-!DD!_!HH!!Min!"

:: Output CSV file with timestamp
set "csv_output=output_!timestamp!.csv"
> "%csv_output%" echo URL,IP Address

echo.
echo URL                                     ^| IP Address
echo ----------------------------------------+--------------------------------------

:: Process each domain in the file
for /f "usebackq delims=" %%D in ("%filename%") do (
  set "url=%%D"
  set "first=1"
  set "found=0"
  set "capture=0"
  set "continuation="

  for /f "usebackq delims=" %%L in (`nslookup "%%D" 2^>^&1`) do (
    set "line=%%L"

    :: When we hit Name:, start capturing (but do not print the Name: line)
    if /i "!line:~0,5!"=="Name:" (
      set "capture=1"
      set "continuation="
    ) else if !capture! EQU 1 (
      :: Detect Address: or Addresses: or continuation lines
      if /i "!line:~0,8!"=="Address:" (
        set "ipraw=!line:~8!"
        set "continuation="
      ) else if /i "!line:~0,10!"=="Addresses:" (
        set "ipraw=!line:~10!"
        set "continuation=1"
      ) else if defined continuation (
        set "ipraw=!line!"
      ) else (
        set "ipraw="
      )

      :: If we found an ipraw value, split by spaces (handles multiple on one line)
      if defined ipraw (
        for %%Z in (!ipraw!) do (
          call :Trim "%%~Z" ipTrimmed
          if defined ipTrimmed (
            if "!first!"=="1" (
              set "first=0"
              set "found=1"
              set "left=!url!!SP!"
              set "left=!left:~0,40!"
              echo !left!^| !ipTrimmed!
              >> "%csv_output%" echo %%D,!ipTrimmed!
            ) else (
              set "leftPad=!SP!"
              set "leftPad=!leftPad:~0,40!"
              echo !leftPad!^| !ipTrimmed!
              >> "%csv_output%" echo %%D,!ipTrimmed!
            )
          )
        )
      )
    )
  )

  if "!found!"=="0" (
    set "left=!url!!SP!"
    set "left=!left:~0,40!"
    echo !left!^| [Lookup failed]
    >> "%csv_output%" echo %%D,[Lookup failed]
  )

  :: Separator between domain blocks
  echo ----------------------------------------+--------------------------------------
)

echo.
endlocal & set "final_output=%csv_output%"
echo Results also saved to "%final_output%"
pause
exit /b

:: -------------------------
:: Trim subroutine - removes leading spaces/tabs from the input string
:: usage: call :Trim "  some text" resultVar
:Trim
setlocal EnableDelayedExpansion
set "tmp=%~1"
for /f "tokens=* delims= " %%A in ("!tmp!") do set "tmp=%%A"
endlocal & set "%~2=%tmp%"
exit /b
