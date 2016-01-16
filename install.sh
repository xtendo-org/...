# echo $USER > /tmp/currentusername
# sudo bash -c "apt-get -y install git vim tree curl silversearcher-ag fish wget openssh-server ca-certificates sudo tmux && \
#     cat /tmp/currentusername | xargs chsh -s /usr/bin/fish"
# rm /tmp/currentusername
mkdir -p ~/tmp
ln -sf ~/.../.vimrc ~/
[ -f ~/.vim/autoload/plug.vim ] || \
    (curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
    vim -c "PlugUpdate | qa")
ln -sf ~/.../.tmux.conf ~/
grep -Fxq "source ~/.../.bashrc" ~/.bashrc || \
    echo "source ~/.../.bashrc" >> ~/.bashrc
[ -e ~/.local/share/omf/README.md ] || \
    curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install\
    | fish
ln -sf ~/.../config.fish ~/.config/fish/config.fish
ln -sf ~/.../gitconfig ~/.gitconfig
ln -sf ~/.../gitexclude ~/.gitexclude
