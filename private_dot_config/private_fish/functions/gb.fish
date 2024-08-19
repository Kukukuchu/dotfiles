function gb
  GIT_PAGER=bat git checkout \
  (git branch --all --sort=-committerdate \
    | grep -v '^\*' \
    | tr -d '[:blank:]' \
    | fzf \
    --query=$argv \
    --reverse \
    --select-1 \
    --ansi \
    --preview 'git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" {} -- 2>/dev/null' \
    | tr -d '[:space:]')
end
