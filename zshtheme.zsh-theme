ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%} ✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo " %B[${ref#refs/heads/}$(git_prompt_short_sha)$( git_prompt_status )%{$reset_color%}%b%B]%b "
  fi
}

function retcode() {}

function _host() {
  if [[ -n $SSH_CONNECTION ]] || [[ -n $AIOAD ]]; then
    echo "%B%m%b"
  fi
}

function _user() {
  if [[ "$DEFAULT_USER" != "$USER" ]]; then
    if [[ "$USER" == "root" ]]; then
      me="%B%U%{\e[31m%}%n%{\e[0m%}%u%b"
    else
      me="%n"
    fi
 
    echo "[%b%{\e[0m%}%{\e[1;32m%}$me%{\e[1;30m%}\e[0;34m%}%B]"
  fi
}

function _python_venv() {
  if [[ $VIRTUAL_ENV != "" ]]; then
    echo "%{$fg[blue]%}(${VIRTUAL_ENV##*/})%{$reset_color%} "
  fi
}

# alternate prompt with git & hg
PROMPT=$'%{\e[0;34m%}%B┌─$(_python_venv)$(_user)[%b%{\e[0m%}%{\e[0;36m%}$(_host)%{\e[0;34m%}%B:%b%{\e[0;34m%}%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%}$(mygit)
%{\e[0;34m%}%B└─▪%b'
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
RPROMPT=$'%{\e[0;34m%}%B[%b%{\e[0m%}%*%{\e[0;34m%}%B]%b%{\e[0m%}'
