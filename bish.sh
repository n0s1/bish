#!/bin/bash
# BISH: The BioShell
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 07/10/2020
# License: GPL v3
# Self replicating modular shell script loader

BISH_CONFIG="$(cat << EOF

[bash]
rc_path = "$HOME/repos/me/dotfiles/.bashrc"

[bish]
home = "$HOME/.config/bish"

[zsh]
rc_path = "$HOME/repos/me/dotfiles/.zshrc"

# New genes (functions) should be defined here
[genes]
    [genes.bish]
            description = "Bish the BioShell"
            remote = "http://bish.n0s1.net/bish.sh"
            command = "bish"
        [genes.bish.depends]
            [genes.bish.depends.toml]
                description = "Read and write toml files"
                remote = "http://core.n0s1.net/out/toml"
                command = "toml"
                use_existing = true
        [genes.bish.submutations]
            [genes.bish.submutations.bish_conf]
                description = "Various tools for working with bish config"
                function = "bish_conf"
                command = "bish conf"
            [genes.bish.submutations.bish_transcribe]
                description = "Write bish, config and mutations to a file"
                function = "bish_transcribe"
                command = "bish transcribe"
            [genes.bish.submutations.bish_layers]
                description = "Load different script layers using bish"
                function = "bish_layers"
                command = "bish layers"

    [genes.n0s1]
        [genes.n0s1.core]
            [genes.n0s1.core.toml]
                description = ""
                remote = "http://core.n0s1.net/out/toml"
                command = "toml"
            [genes.n0s1.core.exprq]
                description = "Evaluate regex cleanly"
                remote = "http://core.n0s1.net/out/exprq"
                command = "exprq"
            [genes.n0s1.core.fzy]
                description = "Small command line fuzzy finder"
                remote = "http://core.n0s1.net/out/fzy"
                command = "fzy"
            [genes.n0s1.core.convert]
                description = "Easily convert between different mediums"
                remote = "http://core.n0s1.net/out/convert"
                command = "convert"
            [genes.n0s1.core.extract]
                description = "Easily extract many types of archives with one cmd"
                remote = "http://core.n0s1.net/out/extract"
                command = "extract"
            [genes.n0s1.core.trypacmaninstall]
                description = "trypacmaninstall"
                remote = "http://core.n0s1.net/out/trypacmaninstall"
                command = "trypacmaninstall"
            [genes.n0s1.core.tryaurinstall]
                description = "tryaurinstall"
                remote = "http://core.n0s1.net/out/tryaurinstall"
                command = "tryaurinstall"
            [genes.n0s1.core.tryaptinstall]
                description = "tryaptinstall"
                remote = "http://core.n0s1.net/out/tryaptinstall"
                command = "tryaptinstall"
            [genes.n0s1.core.wait_any_key]
                description = "wait_any_key"
                remote = "http://core.n0s1.net/out/wait_any_key"
                command = "wait_any_key"
            [genes.n0s1.core.ask]
                description = "ask"
                remote = "http://core.n0s1.net/out/ask"
                command = "ask"
            [genes.n0s1.core.asklink]
                description = "asklink"
                remote = "http://core.n0s1.net/out/asklink"
                command = "asklink"
            [genes.n0s1.core.askrecursivelinkdir]
                description = "askrecursivelinkdir"
                remote = "http://core.n0s1.net/out/askrecursivelinkdir"
                command = "askrecursivelinkdir"
            [genes.n0s1.core.asklinksudo]
                description = "asklinksudo"
                remote = "http://core.n0s1.net/out/asklinksudo"
                command = "asklinksudo"
            [genes.n0s1.core.askclone]
                description = "askclone"
                remote = "http://core.n0s1.net/out/askclone"
                command = "askclone"
            [genes.n0s1.core.setup_ssh]
                description = "setup_ssh"
                remote = "http://core.n0s1.net/out/setup_ssh"
                command = "setup_ssh"
            [genes.n0s1.core.detect_os]
                description = "detect_os"
                remote = "http://core.n0s1.net/out/detect_os"
                command = "detect_os"
            [genes.n0s1.core.arch_pkg_setup]
                description = "arch_pkg_setup"
                remote = "http://core.n0s1.net/out/arch_pkg_setup"
                command = "arch_pkg_setup"
            [genes.n0s1.core.ubuntu_pkg_setup]
                description = "ubuntu_pkg_setup"
                remote = "http://core.n0s1.net/out/ubuntu_pkg_setup"
                command = "ubuntu_pkg_setup"
            [genes.n0s1.core.vim_setup]
                description = "vim_setup"
                remote = "http://core.n0s1.net/out/vim_setup"
                command = "vim_setup"
            [genes.n0s1.core.tmux_setup]
                description = "tmux_setup"
                remote = "http://core.n0s1.net/out/tmux_setup"
                command = "tmux_setup"
            [genes.n0s1.core.setup_symlinks]
                description = "setup_symlinks"
                remote = "http://core.n0s1.net/out/setup_symlinks"
                command = "setup_symlinks"
            [genes.n0s1.core.setup_repos]
                description = "setup_repos"
                remote = "http://core.n0s1.net/out/setup_repos"
                command = "setup_repos"
            [genes.n0s1.core.setup_git]
                description = "setup_git"
                remote = "http://core.n0s1.net/out/setup_git"
                command = "setup_git"
        [genes.n0s1.git_manange]
            description = "Easily manage multiple git repositories"
            remote = "http://core.n0s1.net/out/git_manange"
            command = "gm"
        [genes.n0s1.g]
            description = "Quick shortcuts for common git commands"
            remote = "http://core.n0s1.net/out/g"
            aliases = "g"

    [genes.bliss]
        description = "Bioshell LISp Syntax"
        remote = "http://bish.n0s1.net/bliss"
        command = "bliss"

[system]
    #[system.hosts.mercury]
        #[system.hosts.mercury.packages]
    #[system.hosts.venus]
        #[system.hosts.venus.packages]
    [system.hosts.earth]
        packages = "keychain fd ripgrep fzf bat tmux flameshot synergy youtube-dl mpv youtube-viewer zathura yay vim nodejs yarn ttf-jetbrains-mono alacritty emacs python-neovim unzip xsel bspwm sxhkd polybar"
        [system.hosts.earth.symlinks]
            [system.hosts.earth.symlinks.bashrc]
                source = "$NANOS_REPOS_DIR/dotfiles/.bashrc"
                destination = "$HOME/.bashrc"
                type = "File"
                superreq = false
            [system.hosts.earth.symlinks.xinitrc]
                source = "$NANOS_REPOS_DIR/dotfiles/.xinitrc"
                destination = "$HOME/.xinitrc"
                type = "File"
                superreq = false
            [system.hosts.earth.symlinks.profile]
                source = "$NANOS_REPOS_DIR/dotfiles/.profile"
                destination = "$HOME/.profile"
                type = "File"
                superreq = false
            [system.hosts.earth.symlinks.vimrc]
                source = "$NANOS_REPOS_DIR/dotfiles/.vimrc"
                destination = "$HOME/.vimrc"
                type = "File"
                superreq = false
            [system.hosts.earth.symlinks.xprofile]
                source = "$NANOS_REPOS_DIR/dotfiles/.xprofile"
                destination = "$HOME/.xprofile"
                type = "File"
                superreq = false
            [system.hosts.earth.symlinks.zshenv]
                source = "$NANOS_REPOS_DIR/dotfiles/.zshenv"
                destination = "$HOME/.zshenv"
                type = "File"
                superreq = false
            [system.hosts.earth.symlinks.tmux_conf]
                source = "$NANOS_REPOS_DIR/dotfiles/.tmux.conf"
                destination = "$HOME/.tmux.conf"
                type = "File"
                superreq = false
            [system.hosts.earth.symlinks.dotconfig]
                source = "$NANOS_REPOS_DIR/dotfiles/.config"
                destination = "$HOME/.config"
                type = "Recursive"
                superreq = false
            [system.hosts.earth.symlinks..doom.d]
                source = "$NANOS_REPOS_DIR/dotfiles/.doom.d"
                destination = "$HOME/.doom.d"
                type = "Recursive"
                superreq = false
            [system.hosts.earth.symlinks.hostfile]
                source = "$NANOS_REPOS_DIR/dotfiles/linux/hosts"
                destination = "/etc/hosts"
                type = "File"
                superreq = true
            [system.hosts.earth.symlinks.thinkfan_conf]
                source = "$NANOS_REPOS_DIR/dotfiles/etc/thinkfan.conf"
                destination = "/etc/thinkfan.conf"
                type = "File"
                superreq = true
            [system.hosts.earth.symlinks.awesome_conf]
                source = "$NANOS_REPOS_DIR/dotfiles/etc/xdg/awesome/rc.lua"
                destination = "/etc/xdg/awesome/rc.lua"
                type = "File"
                superreq = true
    #[system.hosts.mars]
        #[system.hosts.mars.packages]
    #[system.hosts.phobos]
        #[system.hosts.phobos.packages]
    #[system.hosts.jupiter]
        #[system.hosts.jupiter.packages]
    #[system.hosts.saturn]
        #[system.hosts.saturn.packages]
    #[system.hosts.uranus]
        #[system.hosts.uranus.packages]
    #[system.hosts.neptune]
        #[system.hosts.neptune.packages]
    #[system.hosts.pluto]
        #[system.hosts.pluto.packages]

    [system.packages]
        [system.packages.keychain]
            name = "keychain"
            description = "Remeber your ssh key passwords until end of session"
        [system.packages.fd]
            name = "fd"
            description = "find but faster"
        [system.packages.ripgrep]
            name = "ripgrep"
            description = "grep but faster"
        [system.packages.fzf]
            name = "fzf"
            description = "fuzzy finder"
        [system.packages.bat]
            name = "bat"
            description = "cat with syntax highlighting"
        [system.packages.tmux]
            name = "tmux"
            description = "terminal multiplexer"
        [system.packages.flameshot]
            name = "flameshot"
            description = "GUI screenshot program"
        [system.packages.synergy]
            name = "synergy"
            description = "mouse/keyboard sharing software"
        [system.packages.youtube-dl]
            name = "youtube-dl"
            description = "download youtube videos"
        [system.packages.mpv]
            name = "mpv"
            description = "video player"
        [system.packages.zathura]
            name = "zathura"
            description = "pdf viewer"
        [system.packages.yay]
            name = "yay"
            description = "AUR package manager"
        [system.packages.vim]
            name = "vim"
            description = "vi improved (text editor)"
        [system.packages.nodejs]
            name = "nodejs"
            description = "javascript package manager"
        [system.packages.yarn]
            name = "yarn"
            description = "package manager"
        [system.packages.ttf-jetbrains-mono]
            name = "ttf-jetbrains-mono"
            description = "jetbrains font"
        [system.packages.alacritty]
            name = "alacritty"
            description = "terminal emulator"
        [system.packages.emacs]
            name = "emacs"
            description = "text editor++"
        [system.packages.neovim]
            name = "python-neovim"
            description = "vim but better"
        [system.packages.unzip]
            name = "unzip"
            description = "unzip files"
        [system.packages.xsel]
            name = "xsel"
            description = "clipboard stuff"
        [system.packages.bspwm]
            name = "bspwm"
            description = "binary space partitioning window manager"
        [system.packages.sxhkd]
            name = "sxhkd"
            description = "simple X hotkey daemon"
        [system.packages.polybar]
            name = "polybar"
            description = "create bars on your desktop"

    [system.repos]
        [system.repos.dotfiles]
            remote = "git@bitbucket.org:Nan0Scho1ar/dotfiles.git"
        [system.repos.scripts]
            remote = "git@bitbucket.org:Nan0Scho1ar/scripts.git"
        [system.repos.vimwiki]
            remote = "git@bitbucket.org:Nan0Scho1ar/vimwiki.git"
        [system.repos.n0s1.core]
            remote = "git@github.com:Nan0Scho1ar/n0s1.core.git"
        [system.repos.bish]
            remote = "git@github.com:Nan0Scho1ar/bish"
        [system.repos.gitmanager]
            remote = "git@github.com:Nan0Scho1ar/gitmanager"

[layers]

    [layers.normal]
        [layers.normal.genes]
            [layers.normal.genes.bish]
                load=true

                [layers.normal.genes.bish.submutations]
                    [layers.normal.genes.bish.submutations.bish_conf]
                        load=true

                    [layers.normal.genes.bish.submutations.bish_transcribe]
                        load=true

                    [layers.normal.genes.bish.submutations.bish_layers]
                        load=true

            [layers.normal.genes.n0s1]
                [layers.normal.genes.n0s1.core]
                    [layers.normal.genes.n0s1.core.toml]
                        load=true

                    [layers.normal.genes.n0s1.core.exprq]
                        load=true

                    [layers.normal.genes.n0s1.core.fzy]
                        load=true

                    [layers.normal.genes.n0s1.core.convert]
                        load=true

                [layers.normal.genes.n0s1.git_manange]
                    load=true

                [layers.normal.genes.n0s1.g]
                    load=true

            [layers.normal.genes.z]
                load=true

            [layers.normal.genes.bliss]
                load=true

# You should not need to touch this.
[state]
    layer="normal"

# Do not change this
EOF
)"

bish() (
    bish_init() { source "$(bish_conf get_value "$BISH_SHELL.rc_path")" || echo "source failed: \$BISH_SHELL not set"; echo -e "bioshell v0.3.1"; }
    bish_conf() { echo "$BISH_CONFIG" | toml "$1" "$2" "$3"; }
    # TODO prompt before sourcing (similar to AUR pkg)
    # TODO Allow choosing curl or wget
    # TODO Should probably handle errors better
    bish_fetch() { curl -fL "$(bish_conf get_value "genes.$1.remote")" > "$2"; }
    # TODO Check if any genes missing from conf
    # TODO Don't double dependencies if met elsewhere
    bish_mutate() {
        bish_home=$(bish_conf get_value bish.home)
        mkdir -p "$bish_home/genes"
        genes="$(bish_conf get genes | sed -n '/depends/d;/submutations/d;s/genes\.\(.*\)\.command=".*"/\1/p')"
        for gene in $genes; do
            echo "Fetching ${yellow}${gene}${reset}";
            bish_fetch "$gene" "$bish_home/genes/$gene"
            cat  "$bish_home/genes/$gene"
            if [[ $1 == "-y" ]]; then
                source "$bish_home/genes/$gene"
            else
                while true; do
                    read -p "Source file? ${yellow}y/n${reset} " -sn1
                    echo
                    [[ $REPLY =~ ^[Yy]$ ]] && source "$bish_home/genes/$gene" && break
                    [[ $REPLY =~ ^[Nn]$ ]] && break
                done
            fi
        done
    }
    # TODO Transcribe alias files (not just commands)
    bish_transcribe() {
        if [ -v $1 ]; then type $gene | tail -n +2; echo; return; fi
        genes="$(bish_conf get genes | sed -n '/depends/d;/submutations/d;s/.*\.command="\(.*\)"/\1/p')"
        echo -e "#!/bin/sh\n# BISH: The BioShell\n# Generated: $(date)\n# License: GPL v3\n"
        echo -e "BISH_CONFIG=\"\$(cat << EOF\n${BISH_CONFIG}\nEOF\n)\"\n"
        for gene in $genes; do type $gene | tail -n +2 && echo; done
        echo -e "\nbish init"
    }
    bish_run() {
        toml -V > /dev/null || source $(curl "core.n0s1.net/out/toml")
        [[ -z $BISH_CONFIG ]] && echo "Error, config variable not set" && return 1
        [[ -z $BISH_SHELL ]] && BISH_SHELL="$(awk -F: -v u="$USER" 'u==$1&&$0=$NF' /etc/passwd | sed 's|/bin/||')";
        case "$1" in
            "init") bish_init ;;
            "errors") bish_transcribe 1>/dev/null ;;
            "transcribe") shift; bish_transcribe $* 2>/dev/null ;;
            "config") shift; bish_conf $* ;;
            "mutate") shift; bish_mutate $* ;;
            "fetch") shift; bish_fetch $* ;;
            *) echo "Unknown option";;
        esac
        #gene="$(bish_conf get "command" "bish $1")";
        #mutation=$(bish_conf get_value "${gene}.function");
        #echo "$mutation $*";
    }
    if [ $# -eq 0 ]; then bish_transcribe 2>/dev/null
    else
        bish_run $*
    fi
)

toml() {
    flatten() {
        comment_regex="^\s*#"
        header_regex="\s*\[.*\]"
        value_regex="\s*.*=.*"
        extract_header="s/\[//g; s/\]//g; s/ //g; s/\t//g; s/\n//g"
        extract_value="s/^\s*//; s/\t//g; s/\n//; s/ =/=/; s/= /=/"

        parent=""
        while IFS= read -r line; do
            if [[ $line =~ $comment_regex ]]; then
                continue
            elif [[ $line =~ $header_regex ]]; then
                parent=$(sed "$extract_header" <<< "$line")
            elif [[ $line =~ $value_regex ]]; then
                if [ -z $parent ]; then
                    sed "$extract_value" <<< "$line"
                else
                    echo "$parent.$(sed "$extract_value" <<< "$line")"
                fi
            fi
        done < /dev/stdin
    }

    #Returns the first value which matches the header
    get_value() {
        match="$1=.*"
        while IFS= read -r line; do
            if [[ $line =~ $match ]]; then
                sed "s/^.*=//" <<< "$line" | tr -d '"'
                break
            fi
        done < <(cat /dev/stdin | flatten)
    }

    # Returns all headers and values matching the input
    get() {
        match="^$1.*"
        while IFS= read -r line; do
            if [[ $line =~ $match ]]; then
                echo "$line"
            fi
        done < <(cat /dev/stdin | flatten)
    }

    case "$1" in
        "get") cat /dev/stdin | get "$2" ;;
        "get_value") cat /dev/stdin | get_value "$2" ;;
        "-V") echo "toml: version 0.7.1" ;;
        *) echo "Error: Unknown option";;
    esac
}

bish init
