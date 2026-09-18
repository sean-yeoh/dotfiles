function fish_greeting
  fastfetch
end

if status is-interactive
  # Commands to run in interactive sessions can go here
end

function gpsup
  git push --set-upstream origin (git branch --show-current)
end

alias gst="git status"
alias gcnm="git commit -n -m"
alias gco="git checkout"
alias gp="git push"
alias gl="git pull"
alias gsta="git stash save"
alias gstp="git stash pop"

source ~/.config/fish/themes/kanagawa.theme

starship init fish | source

if test -f "$HOME/.config/fish/env"
  source "$HOME/.config/fish/env"
end

if test (uname) = "Darwin"
  set -x ANDROID_HOME $HOME/Library/Android/sdk
  fish_add_path /opt/homebrew/share/google-cloud-sdk/bin
else
  fish_add_path $HOME/.local/bin
  mise activate fish | source
  direnv hook fish | source
  set -x ANDROID_HOME $HOME/Android/Sdk
  alias zed="zeditor"
end

set PATH "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools" $PATH

# set agentsmd_source ~/AGENTS.md
# set agentsmd_dest ~/.claude/CLAUDE.md

# if not test -e $agentsmd_dest; and not test -L $agentsmd_dest
#     ln -s $agentsmd_source $agentsmd_dest
# end

# set skills_source ~/.agents/skills
# set skills_dest ~/.claude/skills

# if not test -e $skills_dest; and not test -L $skills_dest
#     ln -s $skills_source $skills_dest
# end

set -Ux PI_CODING_AGENT_DIR "$HOME/.omp/agent"