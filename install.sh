sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install git vim tree curl silversearcher-ag fish
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/.../.tmux.conf ~/
ln -s ~/.../.vimrc ~/
mkdir -p ~/.config/fish
ln -s ~/.../config.fish ~/.config/fish/config.fish
