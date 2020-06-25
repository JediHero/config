# Download neovim appimage file
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
mv ./nvim.appimage /usr/local/bin

# Set the default paths
CUSTOM_NVIM_PATH=/usr/local/bin/nvim.appimage
set -u
sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110

# Create an alias for nvim and vim
echo "alias nvim=/usr/local/bin/nvim.appimage" >> ~/.bashrc
echo "alias vim=/usr/local/bin/nvim.appimage" >> ~/.bashrc

# Copy init.nvim
mkdir ~/.config/nvim -p
cp ./init.nvim ~/.config/nvim

# Copy tmux config
cp ./.tmux.conf ~

# Create other aliases
echo "alias ll=ls -la" >> ~/.bashrc
