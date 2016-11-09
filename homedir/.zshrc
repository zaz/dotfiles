
# TERM="rxvt-unicode-256color"
PATH="$PATH:$HOME/.bin:$HOME/.gem/ruby/2.1.0/bin:$HOME/.rvm/bin"

HISTFILE=~/.cmd_history
HISTSIZE=1000
SAVEHIST=1000

bindkey -e
bindkey "^[[3~" delete-char

setopt auto_cd
setopt auto_pushd
setopt ExtendedGlob PromptSubst AppendHistory Hist_Ignore_dups Hist_Ignore_space CompleteAliases
autoload -Uz compinit && compinit
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' ignored-patterns '(*~)'

alias s='sudo -E '  # the space allows us to use another alias following 's'
compdef s='sudo'

# alias yu='yaourt'
# compdef yu='pacman'
# alias yus='yaourt -Sy'
# alias yuu='yaourt -Syu'
# alias yua='yaourt -Sua'

alias ins='sudo apt-get install'
alias app='sudo apt-get'
compdef app='apt-get'

alias n='urxvtcd -cd "$(pwd)"'
alias startx='startx &> ~/.Xlog'
alias pgd='sudo -u postgres postgres -D /var/postgres'
alias jsw='jekyll serve --watch'
alias sys='sudo systemctl'
compdef sys='systemctl'

function p() {
	case "$1" in
		l ) 1=192.168.0.1 ;;
		w ) 1=172.16.0.1 ;;
		g ) 1=8.8.8.8 ;;
	esac
	ping -fi 0.2 -c ${2:=8} ${1:=8.8.8.8}
}

function o() { (xdg-open $@)& }
alias e='$EDITOR'
alias d='cd ~/Desktop'
alias g='git'
compdef g='git'
alias r='rails'

alias brightness-HDMI1='xrandr --output HDMI1 --brightness'

# Colors:
alias grep='grep --color=auto'
#ls() { /usr/bin/ls --color=auto --group-directories-first "$@" }
alias ls='ls --color=auto --group-directories-first'
eval $(dircolors -b)
PATH="/usr/lib/cw:$PATH"
export LESSOPEN='| /usr/bin/source-highlight-esc.sh %s'
export LESS=' -R '
eval `dircolors ~/.config/solarized.dircolors`


# Prompt with VCS support:
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git bzr svn
precmd() { vcs_info }
zstyle ':vcs_info:git*' formats "%b "
setopt prompt_subst

function prompt {
	echo -n '%B%(?..%{%F{red}%}%? )'
	repo=$(git rev-parse --show-toplevel 2>/dev/null)
	if [ "$repo" = '' ]; then
		echo -n '%{%F{green}%}%~'
	else
		repo="${repo##*/}"
		path=$(git rev-parse --show-prefix)
		path="${path%/}"
		echo -n "%{%F{yellow}%}±${repo}%{%f%}/%{%F{green}%}${path}"
	fi
	echo -n " %{%F{blue}%}${vcs_info_msg_0_}%{%F{green}%}\$%{%f%}%b "
}

PS1='$(prompt)'

# Load RVM into a shell session *as a function*
[[ -s "~/.rvm/scripts/rvm" ]] && source "~/.rvm/scripts/rvm"

export PYTHONPATH=/usr/lib/python3.3/site-packages

# PATH="$PATH:/home/josh/.gem/ruby/2.1.0/bin"
# export PATH

source ~/.config/aliases
