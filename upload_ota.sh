#!/bin/bash
# Upload a compiled .bin to an ESP32 via OTA using espota.py
# You need espota.py (comes with ESP32 Arduino tools) or install via pip: pip3 install esptool
# Usage: ./upload_ota.sh <ESP_IP> <path_to_bin>
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <ESP_IP> <path_to_bin>"
  exit 1
fi

ESP_IP="$1"
BIN="$2"
ESPOTA="${ESPOTA:-espota.py}"   # set ESPOTA env var to point to espota.py if not in PATH
PORT=3232
USERNAME=admin
PASSWORD=admin

if [ ! -f "$BIN" ]; then
  echo "Binary file not found: $BIN"
  exit 2
fi

echo "Uploading $BIN to $ESP_IP ..."
python3 "$ESPOTA" -i "$ESP_IP" -p "$PORT" -f "$BIN" -u "$USERNAME" -P "$PASSWORD" --debug
