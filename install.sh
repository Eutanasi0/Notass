#!/usr/bin/env bash
# Instala notass enlazando los archivos de este repositorio
set -e
REPO="$(cd "$(dirname "$0")" && pwd)"

if ! command -v conky >/dev/null || ! command -v lua >/dev/null; then
    echo "Instalando dependencias (conky, lua)..."
    sudo apt install -y conky-all lua5.1
fi

mkdir -p ~/.local/bin ~/.config/notass ~/.local/share/notass
ln -sf "$REPO/notass" ~/.local/bin/notass
ln -sf "$REPO/notass.conf" ~/.config/notass/notass.conf
ln -sf "$REPO/notass.lua" ~/.config/notass/notass.lua
touch ~/.local/share/notass/notas.txt
chmod +x "$REPO/notass"

echo "notass instalado. Escribe 'notass' para abrirlo."
