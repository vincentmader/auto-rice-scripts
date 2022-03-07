#!/bin/sh

# =============================================================================
#                              AUTO-RICE SCRIPTS
#                                    V.C.M.
# =============================================================================


# RICE-SETUP 
# =============================================================================

# specify: what should be installed and/or setup?
# -----------------------------------------------------------------------------

# package managers
INSTALL_YAY="true" 
INSTALL_BREW="true"             # TODO test installer-download & -setup
INSTALL_MACPORTS="true"         # TODO test installer-download & -setup
INSTALL_GIT="true"

# system setup
CLONE_CONFIG_FILES="true"       # needed
# arch
SETUP_HOMEDIR="false"           # works! (TODO change wallpaper dir)
SETUP_SUCKLESS="false"          # works! (TODO only half-way though)
INITIALIZE_PACMAN="false"       # works!  
INITIALIZE_XORG="true"          # TODO test
SETUP_FONTS="true"
# macOS
SETUP_XCODE="false"             # TODO very unfinished -> test! (at some point) 
UPDATE_SYSTEM="false"           # TODO very unfinished -> test! (at some point) 
UPDATE_CMD_LINE_TOOLS="false"   # TODO very unfinished -> test! (at some point) 

# packages
INSTALL_PKGS="true"             # works!
INSTALL_PKGS_NODE="false"       # TODO fix
INSTALL_PKGS_NVIM="false"       # works!
INSTALL_PKGS_PYTHON="true"      # works!
INSTALL_PKGS_RANGER="false"     # works (I guess, icons should be fixed with font)
INSTALL_PKGS_TMUX="false"       # works!
INSTALL_PKGS_ZSH="false"        # works! (TODO lock-file)
export INSTALL_PKGS_MACPORTS="false"
# more packages                 TODO (rename section?)
INSTALL_RUST="false"            # works (?)
INSTALL_EMACS_DOOM="false"      # works (?)

# configuration
CONFIGURE_GIT="true"
CREATE_SYMLINKS="true"
PULL_GIT_REPOS="true"
CONFIGURE_ZATHURA="true"        # TODO make this system-independent
SETUP_NVIM="false"              # TODO fix & test (not working...)


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
export COLOR_DEFAULT="\033[0m"
export COLOR_BLACK="\033[0;40m"
export COLOR_RED="\033[0;31m"
export COLOR_GREEN="\033[0;32m"
export COLOR_YELLOW="\033[1;33m"
export COLOR_BLUE="\033[1;34m"
export COLOR_MAGENTA="\033[1;35m"
export COLOR_CYAN="\033[1;36m"
export COLOR_WHITE="\033[1;37m"


# PRE-INSTALL SETUP
# =============================================================================

# git
if [ "$INSTALL_GIT" = "true" ]; then   # TODO
    $RICE/install/default/install_git.sh
fi

# clone config-dotfiles
if [ "$CLONE_CONFIG_FILES" = "true" ]; then
    $RICE/pre-install/default/clone_config_files.sh
fi

# initialize pacman
if [ "$OS" = "arch" ] && [ "$INITIALIZE_PACMAN" = "true" ]; then
    $RICE/pre-install/arch/initialize_pacman.sh
fi

# setup home directory
if [ "$OS" = "arch" ] && [ "$SETUP_HOMEDIR" = "true" ]; then
    $RICE/pre-install/arch/setup_home_dir.sh
fi

# create symlinks
if [ "$CREATE_SYMLINKS" = "true" ]; then
    $RICE/pre-install/symlinks/create_symlinks.sh
fi

# initialize xorg
if [ "$OS" = "arch" ] && [ "$INITIALIZE_XORG" = "true" ]; then
    $RICE/pre-install/arch/initialize_xorg.sh
fi

# download/setup fonts
if [ "$OS" = "arch" ] && [ "$SETUP_FONTS" = "true" ]; then
    $RICE/pre-install/arch/setup_fonts.sh
fi

# setup suckless software (dwm + st + dmenu + tabbed (TODO))
if [ "$OS" = "arch" ] && [ "$SETUP_SUCKLESS" = "true" ]; then
    $RICE/pre-install/arch/setup_suckless.sh
fi

# perform macOS system update
if [ "$OS" = "macOS" ] && [ "$UPDATE_SYSTEM" = "true" ]; then
    $RICE/pre-install/macOS/update_system.sh
fi

# perform macOS cmd-line-tools update
if [ "$OS" = "macOS" ] && [ "$UPDATE_CMD_LINE_TOOLS" = "true" ]; then
    $RICE/pre-install/macOS/update_cmd_line_tools.sh
fi

# setup xcode
if [ "$OS" = "macOS" ] && [ "$SETUP_XCODE" = "true" ]; then
    $RICE/pre-install/macOS/setup_xcode.sh
fi


# INSTALL PACKAGE MANAGERS  (and version control system)
# -----------------------------------------------------------------------------

# install yay       (only if running on arch)
if [ "$OS" = "arch" ] && [ $INSTALL_YAY = "true" ]; then
    $RICE/install/os_arch/install_yay.sh
fi

# install brew      (only if running on macOS)
if [ "$OS" = "macOS" ] && [ $INSTALL_BREW = "true" ]; then
    $RICE/install/os_macOS/install_brew.sh
fi

# install macports  (only if running on macOS)
if [ "$OS" = "macOS" ] && [ $INSTALL_MACPORTS = "true" ]; then
    $RICE/install/os_macOS/install_macports.sh
fi


# INSTALL PACKAGES
# =============================================================================

# "default" packages     (-> via brew or pacman/yay)
if [ "$INSTALL_PKGS" = "true" ]; then
    $RICE/install/default/install_packages_default.sh
fi

# mac-specfic packages   (-> via brew)
if [ "$INSTALL_PKGS" = "true" ] && [ "$OS" = "macOS" ]; then
    $RICE/install/os_macOS/install_packages_macOS.sh
fi

# arch-specfic packages  (-> via pacman/yay)
if [ "$INSTALL_PKGS" = "true" ] && [ "$OS" = "arch" ]; then
    $RICE/install/os_arch/install_packages_arch.sh
fi

# zsh plugins            (-> via ohmyzsh)
if [ "$INSTALL_PKGS_ZSH" = "true" ]; then
    $RICE/install/zsh/install_packages_zsh.sh
fi

# python packages        (-> via pip3)
if [ "$INSTALL_PKGS_PYTHON" = "true" ]; then
    $RICE/install/python/install_packages_python.sh
fi

# node packages          (-> via npm)
if [ "$INSTALL_PKGS_NODE" = "true" ]; then
    $RICE/install/node/install_packages_node.sh
fi

# nvim plugins           (-> via vim-plug + conquer-of-completion)
if [ "$INSTALL_PKGS_NVIM" = "true" ]; then
    $RICE/install/nvim/install_packages_nvim.sh
fi

# tmux plugins           (-> via tpm)
if [ "$INSTALL_PKGS_TMUX" = "true" ]; then
    $RICE/install/tmux/install_packages_tmux.sh
fi

# ranger plugins         (-> via git)
if [ "$INSTALL_PKGS_RANGER" = "true" ]; then
    $RICE/install/ranger/install_packages_ranger.sh
fi

# rust                   (-> via installer script)
if [ "$INSTALL_RUST" = "true" ]; then
    $RICE/install/default/install_rust.sh
fi

# emacs (+ doom)
if [ "$INSTALL_EMACS_DOOM" = "true" ]; then
    $RICE/install/default/install_emacs_doom.sh
fi


# POST-INSTALL  (configure packages)
# =============================================================================

# configure git
if [ "$CONFIGURE_GIT" = "true" ]; then
    $RICE/post-install/git/configure_git.sh
fi

# pull git repos
if [ "$PULL_GIT_REPOS" = "true" ]; then
    $RICE/post-install/git/pull_git_repos.sh
fi

# configure zathura
if [ $OS = "macOS" ] && [ "$CONFIGURE_ZATHURA" = "true" ]; then
    $RICE/post-install/zathura-pdf-mupdf/setup_zathura_pdf_mupdf.sh  # TODO rename
fi

# configure neovim
if [ $OS = "arch" ] && [ "$SETUP_NVIM" = "true" ]; then
    $RICE/post-install/nvim/setup_nvim.sh  # TODO rename
fi

