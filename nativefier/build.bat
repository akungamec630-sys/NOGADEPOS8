@echo off
rem Pemakaian: build.bat https://alamat-hosting-anda/index.html
if "%~1"=="" (echo Isi URL tempat index.html di-hosting & exit /b 1)
call npx nativefier@latest --name "POS Toko" --platform windows --arch x64 --single-instance --disable-dev-tools "%~1" out
