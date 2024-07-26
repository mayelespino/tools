#/bin/sh

sudo apt update
sudo apt upgrade
#
sudo apt install -y neovim
#
# Important: If you install bat this way, please note that the executable may be installed as batcat instead of bat (due to a name clash with another package). You can set up a bat -> batcat symlink or alias to prevent any issues that may come up because of this and to be consistent with other distributions:
#
sudo apt install -y bat 
#
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
#
sudo apt install -y gpg
sudo apt install -y python3-pip
sudo apt install -y curl
#
#
#
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
#
#
#
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
#
#
#
