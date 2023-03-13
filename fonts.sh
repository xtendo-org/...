# first, copy your private fonts to ~/.local/share/fonts
set -e
# sudo apt-get install unzip
cd ~/.local/share/fonts
[ -f Envy\%20Code\%20R\%20for\%20Powerline.ttf ] || wget https://gist.github.com/xtendo-org/17b35145d638ea4071d1/raw/e1208f47f9ef365bf29501f16245306620b1f29a/Envy%2520Code%2520R%2520for%2520Powerline.ttf https://gist.github.com/xtendo-org/17b35145d638ea4071d1/raw/e1208f47f9ef365bf29501f16245306620b1f29a/Envy%2520Code%2520R%2520Bold%2520for%2520Powerline.ttf https://gist.github.com/xtendo-org/17b35145d638ea4071d1/raw/e1208f47f9ef365bf29501f16245306620b1f29a/Envy%2520Code%2520R%2520Italic%2520for%2520Powerline.ttf

## Lato is now available in repo
# [ -f Lato2OFL.zip ] || (wget http://www.latofonts.com/download/Lato2OFL.zip && unzip Lato2OFL.zip)

# mkdir -p ~/.config/fontconfig
# ln -sf ~/.../.fonts.conf ~/.config/fontconfig/fonts.conf
fc-cache -v
