#!/bin/bash
DIR=$(readlink -f "$(dirname "$0")")
# DIR=${DIR#$HOME/}  # attempt to make links relative
echo "DIR = ${DIR}"

function lnk {
	to="${DIR}/${1#.}"
	from="${2:-$HOME}/${1}"
	# ln -sT "${from}" "${to}" && \
	echo "${from} -> ${to}"
}

lnk .XCompose
lnk .bashrc.append
lnk .bazaar.conf
lnk .gitconfig
lnk .gitignore_global
lnk .ssh
lnk user-dirs.dirs ~/.config
lnk .vim
lnk .vimrc
lnk .zshrc

# for file in *[^~]
# do
# 	[[ $file = `basename $0` ]] && continue
# 	if [[ $file = "user-dirs.dirs" ]]; then
# 		ln -sT "../$DIR/$file" "$HOME/.config/.$file" && \
# 		echo "$HOME/.config/.$file -> ../$DIR/$file"
# 		continue
# 	fi
# 	ln -sT "$DIR/$file" "$HOME/.$file" && \
# 	echo "$HOME/.$file -> $DIR/$file"
# done
