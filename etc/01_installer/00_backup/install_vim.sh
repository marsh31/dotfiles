sudo apt install python3-dev
sudo apt install lua5.2 liblua5.2-dev
sudo apt install libxmu-dev libgtk2.0-dev libxpm-dev
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev   libgtk2.0-dev libatk1.0-dev libbonoboui2-dev   libcairo2-dev libx11-dev libxpm-dev libxt-dev
sudo apt install python-dev ruby-dev 
sudo apt install libncurses-dev
sudo apt install build-essential 
git clone https://github.com/vim/vim.git
cd vim/src
./configure --with-features=huge --with-x=yes --enable-gui=yes --enable-gtk2-check --enable-python3interp --enable-rubyinterp --enable-pythoninterp --enable-luainterp --enable-multibyte -enable-fail-if-missing
make
sudo make install 
