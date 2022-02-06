<# : work.bat

@echo off
cls
setlocal
setlocal EnableDelayedExpansion
if not exist "%cd%\Sources" mkdir "%cd%\Sources"
if not exist "%cd%\Full" mkdir "%cd%\Full"
if not exist "%cd%\data.csv" echo Name, Count, Algorithm, Time (seconds.ms), Stops >> data.csv
for /f "eol=- delims=" %%a in (path.cfg) do set "%%a"
set pathtogpxcore = %cd%
title %count%


for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    echo  Started %%~nI at: !date!-!time!
	copy "%%~I" "%pathtogpxcore%%%~nxI" 
	cd %pathtogpxcore%
    echo|set /p="'%%~nI',%count%,%algo%," >> data.csv
    python time.py node --max-old-space-size=%ramsize% generate in="%%~nxI" out="%%~nI" type=%algo% count=%count%
	cd %pathtogpxcore%
	echo|set /p="," >> data.csv
	FINDSTR /R /N "^.*" "%%~nxI" | FIND /C ":" >> data.csv
    move "%%~nxI" "%pathtogpxcore%Sources\"
    move "%%~nI.gpx" "%pathtogpxcore%Full\"
	pause
)	
goto :EOF

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }