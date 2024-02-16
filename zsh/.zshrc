autoload -Uz compinit
compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of $HOME/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zmodload zsh/zprof

if [[ -f $HOME/.aliases.sh ]]; then
  source $HOME/.aliases.sh
fi

if [[ -f $HOME/.exports.sh ]]; then
  source $HOME/.exports.sh
fi

if [[ -f $HOME/.work.sh ]]; then
  source $HOME/.work.sh
fi

if [[ -f $HOME/.private.sh ]]; then
  source $HOME/.private.sh
fi

# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
# antidote load 2>/dev/null
antidote load


# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# Using zoxide instead of cd
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh --cmd cd)"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
