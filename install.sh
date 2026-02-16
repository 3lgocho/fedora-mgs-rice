#!/bin/bash

echo "🐍 INICIANDO PROTOCOLO FOXHOUND (Instalación de Entorno)..."

# 1. Instalar Dependencias (Fedora)
echo "[*] Instalando paquetes base..."
sudo dnf install -y alacritty starship fastfetch git curl

# 2. Instalar Fuentes (Terminess Nerd Font)
echo "[*] Descargando Tipografía Táctica..."
mkdir -p ~/.local/share/fonts
curl -fLo "Terminess.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Terminus.zip
unzip -o Terminess.zip -d ~/.local/share/fonts/
rm Terminess.zip
fc-cache -fv

# 3. Mover Archivos de Configuración
echo "[*] Desplegando archivos de configuración..."

# Alacritty
mkdir -p ~/.config/alacritty
cp ./config/alacritty/alacritty.toml ~/.config/alacritty/

# Starship
mkdir -p ~/.config
cp ./config/starship.toml ~/.config/

# Fastfetch
mkdir -p ~/.config/fastfetch
cp -r ./config/fastfetch/* ~/.config/fastfetch/

# 4. Inyectar en .bashrc (Solo si no existe ya)
if ! grep -q "starship init bash" ~/.bashrc; then
    echo "[*] Conectando Starship al Shell..."
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    echo 'fastfetch' >> ~/.bashrc
fi

echo "✅ MISION CUMPLIDA. Reinicia tu terminal."
