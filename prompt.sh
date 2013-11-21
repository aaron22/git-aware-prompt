find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch) "
  else
    git_branch=""
  fi
}

find_git_dirty() {
  # are there any changes in tracked files?
  local status_tracked=$(git status -uno --porcelain 2> /dev/null)
  local status_untracked=$(git status --porcelain 2> /dev/null | grep "?? ")
  if [[ "$status_tracked" != "" ]]; then
    git_dirty='!'
  else
    git_dirty=""
  fi
  if [[ "$status_untracked" != "" ]]; then
    git_dirty="$git_dirty*"
  fi
  if [[ "$git_dirty" != "" ]]; then
    git_dirty="$git_dirty "
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

