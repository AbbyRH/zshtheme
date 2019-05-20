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



function _python_venv() {
  if [[ $VIRTUAL_ENV != "" ]]; then
    echo "%{$fg[blue]%}(${VIRTUAL_ENV##*/})%{$reset_color%} "
  fi
}

bkt_color="%B%{$fg[blue]%}"
function _top_link() {
  top_link='┌─'
  if [[ $USER == 'root' ]]; then
    echo "%B%{$fg[red]%}$top_link%{$reset_color%}%b"
  else
    echo "$bkt_color$top_link%{$reset_color%}%b"
  fi
}

function _bottom_link() {
  bottom_link='└─▪'
  if [[ $USER == 'root' ]]; then
    echo "%B%{$fg[red]%}$bottom_link{%$reset_color%}%b"
  else
    echo "$bkt_color$bottom_link%{$reset_color%}%b"
  fi
}

function _user() {
  if [[ "$DEFAULT_USER" != "$USER" ]]; then
    if [[ "$USER" == "root" ]]; then
      echo "%B%U%{$fg[red]%}[%n]%{$reset_color%}%b%u"
    else
      echo "${bkt_color}[%b%{$fg[green]%}%n${bkt_color}]%{$reset_color%}%b"
    fi
  fi
}

function _host_path() {
  echo "${bkt_color}[%b%{${fg[cyan]}%}$(_host)$bkt_color:%b%{$fg[white]%}%~$bkt_color]%{$reset_color%}$b"
}
function _host() {
  if [[ -n $SSH_CONNECTION ]] || [[ -n $AIOAD ]]; then
    echo "%B%m%b"
  fi
}

get_space () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=""
  (( LENGTH = ${COLUMNS} - $LENGTH - 1))

  for i in {0..$LENGTH}
    do
      SPACES="$SPACES "
    done

  echo $SPACES
}
PROMPT=$'$(_top_link)$(_python_venv)$(_user)$(_host_path)$(mygit)
$(_bottom_link) '
PS2=$' ${\e[0;34m%}%B>%{\e[0m%}%b '
