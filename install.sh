#!/bin/bash

echo "🐍 INICIANDO PROTOCOLO FOXHOUND v2.0 (Despliegue Completo)..."

# 1. Instalar Dependencias (Incluido Tmux y Snapper básico)
echo "[*] Instalando arsenal táctico..."
sudo dnf install -y alacritty starship fastfetch git curl tmux snapper python3-dnf-plugin-snapper

# 2. Instalar Fuentes (Terminess Nerd Font)
echo "[*] Descargando Tipografía..."
mkdir -p ~/.local/share/fonts
curl -fLo "Terminess.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Terminus.zip
unzip -o Terminess.zip -d ~/.local/share/fonts/
rm Terminess.zip
fc-cache -fv

# 3. Desplegar Archivos de Configuración
echo "[*] Copiando esquemas de color..."

# Directorios base
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/fastfetch

# Copias
cp ./config/alacritty/alacritty.toml ~/.config/alacritty/
cp ./config/starship.toml ~/.config/
cp -r ./config/fastfetch/* ~/.config/fastfetch/
cp .tmux.conf ~/  # <--- NUEVO: Copia la config de Tmux

# 4. Inyectar en .bashrc (Starship + Fastfetch + Auto-Tmux)
echo "[*] Conectando sistemas al Shell..."

# Solo si no existe ya Starship
if ! grep -q "starship init bash" ~/.bashrc; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    echo 'fastfetch' >> ~/.bashrc
fi

# Solo si no existe ya el Auto-Start de Tmux
if ! grep -q "tmux attach" ~/.bashrc; then
    echo '' >> ~/.bashrc
    echo '# Auto-start TMUX (MGR-OS)' >> ~/.bashrc
    echo 'if [ -z "$TMUX" ]; then' >> ~/.bashrc
    echo '    tmux attach -t default || tmux new -s default' >> ~/.bashrc
    echo 'fi' >> ~/.bashrc
fi

echo "✅ MISION CUMPLIDA. Reinicia tu terminal para ver Raiden_OS completo."
