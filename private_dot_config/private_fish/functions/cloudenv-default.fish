function cloudenv-default
    set -eg AZURE_CONFIG_DIR
    set -eg KUBECONFIG

    if set -q TMUX
        tmux set-environment -gu AZURE_CONFIG_DIR_(string trim -c% $TMUX_PANE)
        tmux set-environment -gu KUBECONFIG_(string trim -c% $TMUX_PANE)
    end
end
