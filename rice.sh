#!/bin/sh

# =============================================================================
#                              AUTO-RICE SCRIPTS
#                                    V.C.M.
# =============================================================================


# RICE-CONFIG
# =============================================================================

# specify: what should be installed and/or setup?
# -----------------------------------------------------------------------------

# INITIALIZATION

# package managers
INSTALL_GIT="true"
INSTALL_BREW="true"             # TODO test installer-download & -setup
INSTALL_MACPORTS="true"         # TODO test installer-download & -setup
INSTALL_YAY="true" 
INITIALIZE_PACMAN="false"       # works!  
# config
CLONE_CONFIG_FILES="true"       # needed
# arch
SETUP_HOMEDIR="false"           # works! (TODO change wallpaper dir)
SETUP_SUCKLESS="false"          # works! (TODO only half-way though)
INITIALIZE_XORG="true"          # TODO test
SETUP_FONTS="true"
# macOS
SETUP_XCODE="false"             # TODO very unfinished -> test! (at some point) 
UPDATE_SYSTEM="false"           # TODO very unfinished -> test! (at some point) 
# system setup
UPDATE_CMD_LINE_TOOLS="false"   # TODO very unfinished -> test! (at some point) 

# PACKAGE_INSTALLATION
# packages
INSTALL_PKGS="true"             # DEFAULT, works!
INSTALL_PKGS_NODE="true"        # DEFAULT, TODO fix
INSTALL_PKGS_PYTHON="true"      # DEFAULT, works!

INSTALL_PKGS_NVIM="false"       # works!
INSTALL_PKGS_RANGER="false"     # works (I guess, icons should be fixed with font)
INSTALL_PKGS_TMUX="false"       # works!
INSTALL_PKGS_ZSH="false"        # works! (TODO lock-file)
export INSTALL_PKGS_MACPORTS="false"  # TODO fix
# more packages                 TODO (rename section?)
INSTALL_RUST="false"            # works (?)
INSTALL_EMACS_DOOM="false"      # works (?)

# PACKAGE_CONFIGURATION
# configuration
CONFIGURE_GIT="true"
CREATE_SYMLINKS="true"
PULL_GIT_REPOS="true"
CONFIGURE_ZATHURA="true"        # TODO make this system-independent
SETUP_NVIM="false"              # TODO fix & test (not working...)


# RICE-SETUP
# =============================================================================

# setup parameters & environment 
# -----------------------------------------------------------------------------

# get user-name
USER="$(whoami)"
# get operating system -> set $OS & $HOME
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
export RICE=$(pwd)
export SRC=$RICE/src
# create directory for source code files
mkdir -p $RICE/src


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

# INSTALL FROM PKG-FILE
# -----------------------------------------------------------------------------
function install_from_pkg_file {

    TO_INSTALL="$2"
    ALREADY_INSTALLED="$3"

    cat $TO_INSTALL | while read line; do
        if grep -Fxq "$line" "$ALREADY_INSTALLED"; then
            echo "  $COLOR_BLUE**$COLOR_DEFAULT $line"
        else 
            echo "  $COLOR_GREEN++$COLOR_DEFAULT $line"
            $1 "$line"  # run installer-function passed as 1st argument
            echo "$line" >> "$ALREADY_INSTALLED"
        fi
    done
}
export -f install_from_pkg_file


# PRE-INSTALL INITIALIZATION/SETUP
# =============================================================================

# INSTALL PACKAGE MANAGERS & VERSION CONTROL SYSTEM(S)
# -----------------------------------------------------------------------------

# [X] install git version control system
if [ "$INSTALL_GIT" = "true" ]; then
    "$RICE/initialization/default/install_git.sh"
fi

# [ ] initialize pacman (only if running on arch)          TODO: test
if [ "$OS" = "arch" ] && [ $INITIALIZE_PACMAN = "true" ]; then
    "$RICE/initialization/os_arch/initialize_pacman.sh"
fi
# [ ] install yay       (only if running on arch)          TODO: test
if [ "$OS" = "arch" ] && [ $INSTALL_YAY = "true" ]; then
    "$RICE/initialization/os_arch/install_yay.sh"
fi

# [X] install brew      (only if running on macOS)
if [ "$OS" = "macOS" ] && [ $INSTALL_BREW = "true" ]; then
    "$RICE/initialization/os_macOS/install_brew.sh"
fi
# install macports      (only if running on macOS)
if [ "$OS" = "macOS" ] && [ $INSTALL_MACPORTS = "true" ]; then
    "$RICE/initialization/os_macOS/install_macports.sh"
fi

# PERSONAL FILES
# -----------------------------------------------------------------------------

# [ ] setup home directory
if [ "$OS" = "arch" ] && [ "$SETUP_HOMEDIR" = "true" ]; then
    "$RICE/initialization/os_arch/setup_home_dir.sh"
fi

# [ ] clone config-dotfiles
if [ "$CLONE_CONFIG_FILES" = "true" ]; then
    "$RICE/initialization/default/clone_config_files.sh"
fi

# [X] create symlinks
if [ "$CREATE_SYMLINKS" = "true" ]; then
    "$RICE/initialization/symlinks/create_symlinks.sh"
fi

# OS-SPECIFIC: ARCH LINUX
# -----------------------------------------------------------------------------

# [ ] download/setup fonts
if [ "$OS" = "arch" ] && [ "$SETUP_FONTS" = "true" ]; then
    "$RICE/initialization/os_arch/setup_fonts.sh"
fi

# [ ] setup suckless software (dwm + st + dmenu + tabbed (TODO))
if [ "$OS" = "arch" ] && [ "$SETUP_SUCKLESS" = "true" ]; then
    "$RICE/initialization/os_arch/setup_suckless.sh"
fi

# [ ] initialize xorg
if [ "$OS" = "arch" ] && [ "$INITIALIZE_XORG" = "true" ]; then
    "$RICE/initialization/os_arch/initialize_xorg.sh"
fi

# OS-SPECIFIC: MAC OS
# -----------------------------------------------------------------------------

# [ ] perform macOS system update
if [ "$OS" = "macOS" ] && [ "$UPDATE_SYSTEM" = "true" ]; then
    "$RICE/initialization/os_macOS/update_system.sh"
fi

# [ ] perform macOS cmd-line-tools update
if [ "$OS" = "macOS" ] && [ "$UPDATE_CMD_LINE_TOOLS" = "true" ]; then
    "$RICE/initialization/os_macOS/update_cmd_line_tools.sh"
fi

# [ ] setup xcode
if [ "$OS" = "macOS" ] && [ "$SETUP_XCODE" = "true" ]; then
    "$RICE/initialization/os_macOS/setup_xcode.sh"
fi


# INSTALL PACKAGES
# =============================================================================

# [X] mac-specfic packages   (-> via brew)
if [ "$INSTALL_PKGS" = "true" ] && [ "$OS" = "macOS" ]; then
    "$RICE/package-installation/os_macOS/install_packages_macOS.sh"
fi

# [X] arch-specfic packages  (-> via pacman/yay)
if [ "$INSTALL_PKGS" = "true" ] && [ "$OS" = "arch" ]; then
    "$RICE/package-installation/os_arch/install_packages_arch.sh"
fi

# "default" packages     (-> via brew or pacman/yay)
if [ "$INSTALL_PKGS" = "true" ]; then
    "$RICE/package-installation/default/install_packages_default.sh"
fi

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

# nvim plugins           (-> via vim-plug + conquer-of-completion)
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


# POST-INSTALL CONFIGURATION
# =============================================================================

# configure git
if [ "$CONFIGURE_GIT" = "true" ]; then
    "$RICE/package-setup/git/configure_git.sh"
fi

# pull git repos
if [ "$PULL_GIT_REPOS" = "true" ]; then
    "$RICE/package-setup/git/pull_git_repos.sh"
fi

# configure zathura
if [ $OS = "macOS" ] && [ "$CONFIGURE_ZATHURA" = "true" ]; then
    "$RICE/package-setup/zathura-pdf-mupdf/setup_zathura_pdf_mupdf.sh"  # TODO rename
fi

# configure neovim
if [ $OS = "arch" ] && [ "$SETUP_NVIM" = "true" ]; then
    "RICE/package-setup/nvim/setup_nvim.sh"  # TODO rename
fi

