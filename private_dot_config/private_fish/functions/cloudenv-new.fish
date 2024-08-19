function cloudenv-new --description 'Override default az and kubectl config locations via setting environment variables AZURE_CONFIG_DIR and KUBECONFIG. By default use ~/.config/azure|kube/%name% where name is argument provided to function. Name defaults to current dir basename'
    argparse h/help 'n/name=?' -- $argv
    or return

    if set -ql _flag_name
        set -f projname $_flag_name
    else
        set -f projname (path basename (pwd))
    end

    set -gx AZURE_CONFIG_DIR $HOME/.config/azure/$projname
    mkdir -p $AZURE_CONFIG_DIR
    set -gx KUBECONFIG $HOME/.config/kube/$projname/config
    mkdir -p $HOME/.config/kube/$projname

    if set -qg TMUX
        tmux set-environment -g AZURE_CONFIG_DIR_(string trim -c% $TMUX_PANE) $AZURE_CONFIG_DIR
        tmux set-environment -g KUBECONFIG_(string trim -c% $TMUX_PANE) $KUBECONFIG
    end

end
