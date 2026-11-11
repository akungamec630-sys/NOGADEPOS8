#!/usr/bin/env bash
# Pemakaian: ./build.sh https://alamat-hosting-anda/index.html
# Nativefier membungkus URL (bukan file lokal). Jalankan di Windows untuk hasil .exe.
set -e
URL="${1:?Isi URL tempat index.html di-hosting}"
npx nativefier@latest --name "POS Toko" --platform windows --arch x64 \
  --single-instance --disable-dev-tools "$URL" ./out
