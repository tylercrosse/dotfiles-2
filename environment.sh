#!/usr/bin/env bash

##############################
#  Colors
##############################

# generic colouriser
GRC=$(which grc)
if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
  alias colourify="$GRC -es --colour=auto"
  alias configure='colourify ./configure'
  for app in {diff,make,gcc,g++,ping,traceroute}; do
    alias "$app"='colourify '$app
  done
fi

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

##############################
#  Bash Completion
##############################

# z beats cd most of the time.
#   github.com/rupa/z
# source ~/dev/dotfiles/z.sh

# fz completion https://github.com/changyuheng/fz
# if [ -d ~/.bash_completion.d ]; then
#   for file in ~/.bash_completion.d/*; do
#     . $file
#   done
# fi

# bash completion.
if which brew >/dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# homebrew completion
# https://github.com/Homebrew/legacy-homebrew/blob/4251efa88cc6cc3e937dd2d97cbf745a348d09e8/Library/Contributions/brew_bash_completion.sh
# if  which brew > /dev/null; then
#     source `brew --repository`/Library/Contributions/brew_bash_completion.sh
# fi;

# hub completion
if which hub >/dev/null; then
  source "$(brew --prefix)/etc/bash_completion.d/hub.bash_completion.sh"
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &>/dev/null; then
  __git_complete g __git_main
fi

##############################
#  Environments & Settings
##############################

# https://gist.github.com/phette23/5270658#file-current-dir-in-iterm-tab-title-sh
if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND"
fi

# ruby envrioment rbenv
eval "$(rbenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/tylercrosse/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/Users/tylercrosse/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/Users/tylercrosse/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/Users/tylercrosse/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<
