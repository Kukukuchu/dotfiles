if status is-interactive
    #Commands to run in interactive sessions can go here
    
    if string match -q "$TERM_PROGRAM" "vscode"
        # Only necessary if built-in integration does not work
        # . (code --locate-shell-integration-path fish)
        set -gx SUDO_EDITOR "$(which code) -w"
        set -gx EDITOR "$(which code) -w -r"
        set -gx VISUAL "$(which code) -w -r"
    end

    fzf_configure_bindings --directory=\cE --git_log=\eg --git_status=\eh --processes=\ep --variables=\ev
    abbr --add l ls -a
    zoxide init fish | source
    # fnm env --use-on-cd | source
    # fish_ssh_agent
end

# This should no longer be necessary if conf.d/_00-linuxbrew.fish sets up 
# brew vendor config and direnv is installed via brew
# direnv hook fish | source
