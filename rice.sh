#!/bin/sh

# =============================================================================
#                              AUTO-RICE SCRIPTS
#                                    V.C.M.
# =============================================================================


# RICE-CONFIG
# =============================================================================

DO_FULL_SYSTEM_UPGRADE="false"     # 

# SETUP
INITIALIZE_PACMAN="true"
SETUP_HOMEDIR="true"            # works! (TODO change wallpaper dir)

# ARCH-SPECIFIC
SETUP_SUCKLESS="false"           # works! (TODO only half-way though)
INITIALIZE_XORG="true"          # TODO test
SETUP_FONTS="true"
# MACOS-SPECIFIC
SETUP_XCODE="false"             # TODO very unfinished -> test! (at some point) 
UPDATE_SYSTEM="false"           # TODO very unfinished -> test! (at some point) 
UPDATE_CMD_LINE_TOOLS="false"   # TODO very unfinished -> test! (at some point) 

# PACKAGE_INSTALLATION
INSTALL_PKGS="false"
INSTALL_EMACS_DOOM="true"      # works (?)
INSTALL_RUST="false"            # works (?)
INSTALL_PKGS_TMUX="true"        # works!
INSTALL_PKGS_ZSH="false"        # works! (TODO lock-file)
INSTALL_PKGS_RANGER="true"     # works!
INSTALL_PKGS_PYTHON="true"      # works!
INSTALL_PKGS_NODE="false"       # works!
INSTALL_PKGS_NVIM="false"       # works! (but not really needed)


# RICE-SETUP
# =============================================================================

# setup parameters & environment 
# -----------------------------------------------------------------------------

# get user-name
USER="$(whoami)"
# get operating system -> set "$OS" & "$HOME"
if [[ "$OSTYPE" == "darwin"* ]]; then
    export OS="macOS"
    export HOME="/Users/$USER"
elif [[ "$OSTYPE" == "linux"* ]]; then
    export OS="arch"  # TODO be more specific: arch / ubuntu / ... ?
    export HOME="/home/$USER"
fi
# get location of config files
export CONF="$HOME/.config"
# get location of auto-rice scripts (location of this file)
cd "$(dirname $0)"
export RICE="$(pwd)"
export SRC="$RICE/src"
# create directory for source code files
mkdir -p "$RICE/src"

if [ "$DO_FULL_SYSTEM_UPGRADE" = "true" ]; then
    for i in $RICE/package-installation/**/pkgs_*/installed.txt; do
        > $i  # clear file content
    done
fi


# define package manager (os-dependent)
# -----------------------------------------------------------------------------

# arch -> pacman
if [ "$OS" = "macOS" ] ; then
    export PACKAGE_MANAGER="brew install"
# macOS -> brew
elif [ "$OS" = "arch" ] ; then
    export PACKAGE_MANAGER="yay -S"  # TODO switch to yay?
# exit on undefined
else
    echo "Please specify the OS ('arch' or 'macOS')"
    exit 1
fi


# PRINTING SETUP
# -----------------------------------------------------------------------------
export COLOR_DEFAULT="\033[0m"
export COLOR_BLACK="\033[0;40m"
export COLOR_RED="\033[0;31m"
export COLOR_GREEN="\033[0;32m"
export COLOR_YELLOW="\033[1;33m"
export COLOR_BLUE="\033[1;34m"
export COLOR_MAGENTA="\033[1;35m"
export COLOR_CYAN="\033[1;36m"
export COLOR_WHITE="\033[1;37m"

if [ "$OS" = "arch" ] ; then
    export alias echo="echo -e"
fi

# INSTALL FROM PKG-FILE
# -----------------------------------------------------------------------------
function install_from_pkg_file {

    TO_INSTALL="$2"
    ALREADY_INSTALLED="$3"

    if [[ ! -f "$ALREADY_INSTALLED" ]]; then
        touch "$ALREADY_INSTALLED"
    fi

    grep -v '^#' $TO_INSTALL | while read line; do
        if grep -Fxq "$line" "$ALREADY_INSTALLED"; then
            echo "$COLOR_BLUE** $line$COLOR_DEFAULT"
        else 
            echo "$COLOR_GREEN++ $line$COLOR_DEFAULT"
            $1 "$line"  # run installer-function passed as 1st argument
            echo "$line" >> "$ALREADY_INSTALLED"
        fi
    done
}
export -f install_from_pkg_file

function printc {
    MSG="$1"
    echo "\n$COLOR_BLUE$MSG$COLOR_DEFAULT"
}
export -f printc

function echo_separator {
    CHAR="$1"
    SEPARATOR=""
    for (( col_idx=1; col_idx<=$(tput cols); col_idx++ )); do
        SEPARATOR="$SEPARATOR$CHAR"
    done
    echo "$SEPARATOR"
}
export SEPARATOR_1=$(echo_separator "-")
export SEPARATOR_2=$(echo_separator "=")

function echo_title {
    AUTHOR="Vincent C. Mader"
    PROJECT_NAME="AUTO-RICE SCRIPTS"

    MSG="$PROJECT_NAME"
    START_IDX=0
    END_IDX=$(( $(tput cols) - ${#PROJECT_NAME} - ${#AUTHOR} - 1 ))
    for (( col_idx=$START_IDX; col_idx<=$END_IDX; col_idx++ )); do
        MSG="$MSG "
    done
    MSG="$MSG$AUTHOR"

    echo
    printc "$SEPARATOR_1$MSG$SEPARATOR_1"
}

# MAIN SCRIPT
# =============================================================================
echo_title

# PRE-INSTALL INITIALIZATION/SETUP
# =============================================================================
printc "$SEPARATOR_2\nINITIALIZATION\n$SEPARATOR_2"


# INSTALL PACKAGE MANAGERS & VERSION CONTROL SYSTEM(S)
# -----------------------------------------------------------------------------

# [X] install git version control system
"$RICE/initialization/default/install_git.sh"

# [ ] arch-specific initialization
if [ "$OS" = "arch" ]; then

    if [ "$INITIALIZE_PACMAN" = "true" ]; then
        # [X] initialize pacman 
        "$RICE/initialization/os_arch/initialize_pacman.sh"
        # [X] install yay
        "$RICE/initialization/os_arch/install_yay.sh"
    fi

# [X] macOS-specific initialization
elif [ "$OS" = "macOS" ]; then

    # [X] install brew 
    "$RICE/initialization/os_macOS/install_brew.sh"
    # [ ] install macports
    "$RICE/initialization/os_macOS/install_macports.sh"

fi

# [ ] setup home directory
"$RICE/initialization/default/setup_home_dir.sh"

# [X] clone config-dotfiles
"$RICE/initialization/default/clone_config_files.sh"

# [X] create symlinks
"$RICE/initialization/symlinks/create_symlinks.sh"

# OS-SPECIFIC: ARCH LINUX
# -----------------------------------------------------------------------------

if [ "$OS" = "arch" ]; then

    # [ ] download/setup fonts
    if [ "$SETUP_FONTS" = "true" ]; then  # TODO fix for st
        "$RICE/initialization/os_arch/setup_fonts.sh"
    fi
    # [X] setup suckless software (dwm + st + dmenu + tabbed)
    if [ "$SETUP_SUCKLESS" = "true" ]; then
        "$RICE/initialization/os_arch/setup_suckless.sh"
    fi
    # [ ] initialize xorg
    if [ "$INITIALIZE_XORG" = "true" ]; then
        "$RICE/initialization/os_arch/initialize_xorg.sh"
    fi

fi

# OS-SPECIFIC: MAC OS
# -----------------------------------------------------------------------------

if [ "$OS" = "macOS" ]; then

    # [ ] perform macOS system update
    if [ "$UPDATE_SYSTEM" = "true" ]; then
        "$RICE/initialization/os_macOS/update_system.sh"
    fi
    
    # [ ] perform macOS cmd-line-tools update
    if [ "$UPDATE_CMD_LINE_TOOLS" = "true" ]; then
        "$RICE/initialization/os_macOS/update_cmd_line_tools.sh"
    fi
    
    # [ ] setup xcode
    if [ "$SETUP_XCODE" = "true" ]; then
        "$RICE/initialization/os_macOS/setup_xcode.sh"
    fi

fi


# INSTALL PACKAGES
# =============================================================================
printc "$SEPARATOR_2\nPACKAGE INSTALLATION\n$SEPARATOR_2"

# [X] os-independent packages    -> via brew or pacman/yay
if [ "$INSTALL_PKGS" = "true" ]; then

    # TODO fix error on
    # - archey 
    # - gotop 
    # - lf

    "$RICE/package-installation/default/install_packages_default.sh"
    if [ "$OS" = "macOS" ]; then   # -> via brew
       "$RICE/package-installation/os_macOS/install_packages_macOS.sh"
    elif [ "$OS" = "arch" ]; then  # -> via pacman/yay
        "$RICE/package-installation/os_arch/install_packages_arch.sh"
    fi
    # "$RICE/package-installation/gem/install_packages_gem.sh"
    
    # zsh plugins            (-> via ohmyzsh)
    if [ "$INSTALL_PKGS_ZSH" = "true" ]; then
        "$RICE/package-installation/zsh/install_packages_zsh.sh"
    fi
    
    # python packages        (-> via pip3)
    if [ "$INSTALL_PKGS_PYTHON" = "true" ]; then
        "$RICE/package-installation/python/install_packages_python.sh"
    fi
    
    # node packages          (-> via npm)
    if [ "$INSTALL_PKGS_NODE" = "true" ]; then
        "$RICE/package-installation/node/install_packages_node.sh"
    fi
    
    # nvim plugins           (-> via vim-plug + conqueror-of-completion)
    if [ "$INSTALL_PKGS_NVIM" = "true" ]; then
        "$RICE/package-installation/nvim/install_packages_nvim.sh"
    fi
    
    # tmux plugins           (-> via tpm)
    if [ "$INSTALL_PKGS_TMUX" = "true" ]; then
        "$RICE/package-installation/tmux/install_packages_tmux.sh"
    fi
    
    # ranger plugins         (-> via git)
    if [ "$INSTALL_PKGS_RANGER" = "true" ]; then
        "$RICE/package-installation/ranger/install_packages_ranger.sh"
    fi

    # rust                   (-> via installer script)
    if [ "$INSTALL_RUST" = "true" ]; then
        "$RICE/package-installation/default/install_rust.sh"
    fi

    # emacs (+ doom)
    if [ "$INSTALL_EMACS_DOOM" = "true" ]; then
        "$RICE/package-installation/default/install_emacs_doom.sh"
    fi
fi



# POST-INSTALL CONFIGURATION
# =============================================================================
printc "$SEPARATOR_2\nPOST-INSTALL CONFIGURATION\n$SEPARATOR_2"

# configure git
"$RICE/package-setup/git/configure_git.sh"   # after symlinks

# pull git repos
"$RICE/package-setup/git/pull_git_repos.sh"

if [ "$OS" = "macOS" ]; then

    # configure zathura       # TODO make this system-independent
    "$RICE/package-setup/zathura-pdf-mupdf/setup_zathura_pdf_mupdf.sh"

    # configure mactex install  TODO move to own file?
    printc "Configuring macTeX..."
    eval "$(/usr/libexec/path_helper)"
    echo "Configured macTeX."

    # configure automatic startup-launch of mongod 
    # TODO make this system-independent
    # TODO move to own file/
    printc "Configuring mongodb..."
    brew services start mongodb/brew/mongodb-community > /dev/null
    echo "Started mongod."

    # configure skhd  TODO auto-start on login?
    printc "Configuring skhd..."
    # brew services start skhd > /dev/null
    printf "$COLOR_YELLOW"
    echo "WARN: This might need manual setup!$COLOR_DEFAULT"
    echo "      Run 'brew services start skhd' to start the daemon."
    echo "      Run 'skhd' to enable the necessary authentifications from System Preferencs!"
    # echo "Started skhd."

    # configure yabai   # TODO auto-start on login?
    printc "Configuring yabai..."
    printf "$COLOR_YELLOW"
    echo "WARN: This might need manual setup!$COLOR_DEFAULT"
    echo "      Follow this guide: https://github.com/koekeishiya/yabai/wiki$COLOR_DEFAULT"

fi

