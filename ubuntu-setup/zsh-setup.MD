# Update system
sudo apt update && sudo apt upgrade -y

# Essential tools
sudo apt install -y git make curl zsh

# Switch to zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh (with unattended flag)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Kitty terminal install
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
echo 'export PATH="$HOME/.local/kitty.app/bin:$PATH"' >> ~/.zshrc
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/kitty

# Tools & packages
sudo apt install -y fastfetch pulseaudio pavucontrol ffmpeg ripgrep unrar unzip htop unclutter fzf eza lm-sensors \
fortune-mod cowsay lolcat cmatrix

# Sway
sudo apt install sway waybar rofi flameshot \
pavucontrol alsa-utils brightnessctl wl-clipboard xdg-desktop-portal-wlr \
fonts-font-awesome fonts-jetbrains-mono network-manager-gnome redshift-gtk \
xdg-utils grim slurp nautilus swaybg autotiling playerctl swappy \
dunst libnotify-bin swaylock swayidle

# Brave + VSCode + Insomnia
sudo snap install brave
sudo snap install code --classic
sudo snap install insomnia

curl -L -o steam.deb https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb && sudo apt install ./steam.deb

# Go
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go
echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.zshrc

# Node.js
sudo apt install -y curl gnupg
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs

# Odin + LLVM 20
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 20
echo 'export PATH="/usr/lib/llvm-20/bin:$PATH"' >> ~/.zshrc
git clone https://github.com/odin-lang/Odin ~/Odin
cd ~/Odin && make release-native
echo 'export PATH="$HOME/Odin:$PATH"' >> ~/.zshrc

# Docker
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker

# Neovim
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
sudo mv nvim-linux64/bin/nvim /usr/local/bin/
echo "alias vim='nvim'" >> ~/.zshrc
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Nerd font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv
