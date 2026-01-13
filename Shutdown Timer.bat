@echo off
chcp 65001 >nul
cls
setlocal enabledelayedexpansion

:menu
cls
echo.
echo ╔════════════════════════════════════╗
echo ║      APLIKASI SHUTDOWN TIMER       ║
echo ╚════════════════════════════════════╝
echo.
echo [1] Matikan komputer dengan timer
echo [2] Batal matikan komputer
echo [3] Keluar
echo.
set /p pilihan="Pilih menu [1-3]: "

if "%pilihan%"=="1" goto timer
if "%pilihan%"=="2" goto batal
if "%pilihan%"=="3" goto keluar
cls
echo Pilihan tidak valid! Silakan coba lagi.
timeout /t 2 >nul
goto menu

:timer
cls
echo.
echo ════════════════════════════════════
echo        ATUR WAKTU SHUTDOWN
echo ════════════════════════════════════
echo.
set /p jam="Masukkan jam (0-23): "
set /p menit="Masukkan menit (0-59): "
echo.

REM Validasi input
for /f %%A in ('powershell -Command "if([int]'%jam%' -ge 0 -and [int]'%jam%' -le 23 -and [int]'%menit%' -ge 0 -and [int]'%menit%' -le 59){echo 1}else{echo 0}"') do set valid=%%A

if "%valid%"=="0" (
    cls
    echo [ERROR] Input tidak valid! Jam harus 0-23, Menit harus 0-59.
    timeout /t 2 >nul
    goto timer
)

REM Hitung detik
set /a total_detik=jam*3600+menit*60

cls
echo.
echo ════════════════════════════════════
echo.
echo Komputer akan dimatikan dalam:
echo • %jam% jam %menit% menit
echo • Total: %total_detik% detik
echo.
echo Tekan ENTER untuk konfirmasi atau
echo tutup jendela ini untuk membatalkan.
echo.
pause >nul

REM Jalankan shutdown command
shutdown /s /t %total_detik% /c "Komputer akan dimatikan otomatis" /f

cls
echo.
echo ════════════════════════════════════
echo ✓ SHUTDOWN TIMER AKTIF
echo ════════════════════════════════════
echo.
echo Waktu shutdown: %jam% jam %menit% menit
echo.
echo Untuk membatalkan, buka aplikasi ini
echo kembali dan pilih menu [2] BATAL
echo.
pause >nul
goto menu

:batal
cls
echo.
echo ════════════════════════════════════
echo.
echo Membatalkan shutdown...
echo.
shutdown /a
timeout /t 1 >nul

if errorlevel 1 (
    echo [INFO] Tidak ada jadwal shutdown yang aktif
) else (
    echo ✓ Shutdown berhasil dibatalkan!
)

echo.
echo ════════════════════════════════════
echo.
pause >nul
goto menu

:keluar
cls
echo Terima kasih telah menggunakan Shutdown Timer!
timeout /t 2 >nul
exit /b
