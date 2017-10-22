set -e # stop immediately if anything fails

# echo $USER > /tmp/currentusername
# sudo bash -c "apt-get -y install git vim tree curl silversearcher-ag fish wget openssh-server ca-certificates sudo tmux && \
#     cat /tmp/currentusername | xargs chsh -s /usr/bin/fish"
# rm /tmp/currentusername

echo "Configuring Vim..."
mkdir -p ~/tmp
ln -sf ~/.../vimrc ~/
[ -f ~/.vim/autoload/plug.vim ] || \
    (curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
    vim -c "PlugUpdate | qa")
echo "Configuring Tmux..."
ln -sf ~/.../.tmux.conf ~/
echo "Configuring bash..."
grep -Fxq "source ~/.../.bashrc" ~/.bashrc || \
    echo "source ~/.../.bashrc" >> ~/.bashrc

echo "Configuring fish..."
mkdir -p ~/.config/fish/config/fish
ln -sf ~/.../config.fish ~/.config/fish/config.fish

echo "Configuring Git..."
ln -sf ~/.../gitconfig ~/.gitconfig
ln -sf ~/.../gitexclude ~/.gitexclude
