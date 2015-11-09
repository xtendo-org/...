sudo bash -c "apt-get update &&
apt-get -y upgrade &&
apt-get -y install git vim tree curl silversearcher-ag fish wget openssh-server ca-certificates sudo tmux"
[ -f ~/.vim/autoload/plug.vim ] || \
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf ~/.../.tmux.conf ~/
ln -sf ~/.../.vimrc ~/
mkdir -p ~/.config/fish
ln -sf ~/.../config.fish ~/.config/fish/config.fish
