# first, copy your private fonts to ~/.fonts.
# requires unzip
set -e
sudo apt-get install unzip
cd ~/.fonts
wget https://gist.github.com/kinoru/17b35145d638ea4071d1/raw/e1208f47f9ef365bf29501f16245306620b1f29a/Envy%2520Code%2520R%2520for%2520Powerline.ttf https://gist.github.com/kinoru/17b35145d638ea4071d1/raw/e1208f47f9ef365bf29501f16245306620b1f29a/Envy%2520Code%2520R%2520Bold%2520for%2520Powerline.ttf https://gist.github.com/kinoru/17b35145d638ea4071d1/raw/e1208f47f9ef365bf29501f16245306620b1f29a/Envy%2520Code%2520R%2520Italic%2520for%2520Powerline.ttf
wget http://www.latofonts.com/download/Lato2OFL.zip
unzip Lato2OFL.zip
ln -sf ~/.../.fonts.conf ~/.config/fontconfig/fonts.conf
ln -sf ~/.config/fontconfig/fonts.conf ~/.fonts.conf
fc-cache -v
