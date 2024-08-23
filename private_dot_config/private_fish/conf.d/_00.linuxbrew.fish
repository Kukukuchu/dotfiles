if test -x /home/linuxbrew/.linuxbrew/bin/brew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)
  # Point to Brewile to use with `brew bundle` command to install packages declaratively
  set -gx HOMEBREW_BUNDLE_FILE /home/dmrp/.config/homebrew/Brewfile
else
  echo "Brew not found"
end

if type -q brew
  # Add /home/linuxbrew/.linuxbrew/share to XDG_DATA_DIRS
  set -x --path XDG_DATA_DIRS $XDG_DATA_DIRS
  set -q XDG_DATA_DIRS[1]; or set XDG_DATA_DIRS /usr/local/share /usr/share
  set -p XDG_DATA_DIRS (brew --prefix)/share

  # Source /home/linuxbrew/.linuxbrew/share/fish/vendor_conf.d
  # This contains fish configuration of packages installed via brew
  set -l brew_confdir (brew --prefix)/share/fish/vendor_conf.d
  set -l sourcelist
  for file in $brew_confdir/*.fish
    set -l basename (string replace -r '^.*/' '' -- $file)
    contains -- $basename $sourcelist
    and continue
    set sourcelist $sourcelist $basename
    # Also skip non-files or unreadable files.
    # This allows one to use e.g. symlinks to /dev/null to "mask" something (like in systemd).
    test -f $file -a -r $file
    and source $file
  end

  # Add /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d and .../completions to fish completion sources
  # This is where packages installed via brew add their completions
  if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
  end

  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
  end
else
  echo "Brew setup didn't finish"
end
