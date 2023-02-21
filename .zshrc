# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
(cat ~/.cache/wal/sequences &)
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nakul2/.zshrc'
set -o PROMPT_SUBST
PS1="[%/]~ $ "
autoload -Uz compinit
compinit
# End of lines added by compinstall
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
export PATH=~/.local/bin/:$PATH
#named dirs
hash -d h=/home/nakul2/
hash -d cf=/home/nakul2/.config/
