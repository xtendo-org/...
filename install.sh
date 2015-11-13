echo $USER > /tmp/currentusername
sudo bash -c "apt-get -y install git vim tree curl silversearcher-ag fish wget openssh-server ca-certificates sudo tmux && \
    cat /tmp/currentusername | xargs chsh -s /usr/bin/fish"
rm /tmp/currentusername
[ -f ~/.vim/autoload/plug.vim ] || \
    (curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
    vim -c "PlugUpdate | qa")
ln -sf ~/.../.tmux.conf ~/
ln -sf ~/.../.vimrc ~/
grep -Fxq "source ~/.../.bashrc" ~/.bashrc || \
    echo "source ~/.../.bashrc" >> ~/.bashrc
mkdir -p ~/.config/fish
ln -sf ~/.../config.fish ~/.config/fish/config.fish
