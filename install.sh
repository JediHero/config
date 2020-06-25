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

# nvim config
mkdir ~/.config/nvim -p
cp ./init.vim ~/.config/nvim

# tmux config
cp ./.tmux.conf ~

# git config
git config --global user.name = "Rusty Hansen"
git config --global user.email = "hansen.rusty@gmail.com"
git config --global core.editor = "nvim"
cp ./.gitignore_global ~

# Create other aliases
echo 'alias ll="ls -la"' >> ~/.bashrc
echo 'alias gu="git push -u origin master"' >> ~/.bashrc
echo 'alias gs="git status"' >> ~/.bashrc

# Reset the shell
exec $SHELL
