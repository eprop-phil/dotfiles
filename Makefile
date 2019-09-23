.PHONY: all

all: brew zsh composer fonts

brew:
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew bundle

composer:
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php --install-dir=usr/local/bin
	php -r "unlink('composer-setup.php');"

zsh:
	chsh -s $(which zsh)
	ln -s $(realpath zshrc) ~/.zshrc

editor-setup:
	ln -s $(realpath settings.json) ~/Library/Application\ Support/Code/User/settings.json
	ln -s $(realpath keybindings.json) ~/Library/Application\ Support/Code/User/keybindings.json

fonts:
	git clone https://github.com/powerline/fonts.git
	fonts/install.sh
	rm -r fonts
