#!/bin/sh

# =============================================================================
#                              AUTO-RICE SCRIPTS
#                                    v.c.m.
# =============================================================================


# SETUP 
# =============================================================================

# specify: what should be installed and/or setup?
# -----------------------------------------------------------------------------

# package managers
INSTALL_YAY=false          # TODO test
INSTALL_BREW=false         # TODO test
INSTALL_MACPORTS=false     # TODO test

# system setup
CLONE_CONFIG_FILES=true
# arch
SETUP_HOMEDIR=false        # TODO test
SETUP_SUCKLESS=false       # TODO test
INITIALIZE_PACMAN=false    # TODO test
INITIALIZE_XORG=false      # TODO test
# macOS
SETUP_XCODE=false          # TODO test

# packages
INSTALL_PKGS=false
INSTALL_PKGS_NODE=false
INSTALL_PKGS_NVIM=false
INSTALL_PKGS_PYTHON=false
INSTALL_PKGS_RANGER=false
INSTALL_PKGS_TMUX=false
INSTALL_PKGS_ZSH=false
# more packages             TODO (rename section?)
INSTALL_RUST=false        # TODO test
INSTALL_EMACS_DOOM=false   
INSTALL_GIT=false

# configuration
CONFIGURE_GIT=false
CREATE_SYMLINKS=true
PULL_GIT_REPOS=false


# setup parameters & environment 
# -----------------------------------------------------------------------------

# get operating system from script argument  (options: "macOS" or "arch")
export OS="$1"    

# get location of auto-rice scripts (location of this file)
export RICE=$(dirname $0)
export SRC=$RICE/src

# create directory for source code files
mkdir -p $RICE/src


# define package manager
# -----------------------------------------------------------------------------

# define package manager  (arch -> pacman, macOS -> brew)
if [ "$OS" = "macOS" ] ; then
    export PACKAGE_MANAGER="brew install"
elif [ "$OS" = "arch" ] ; then
    export PACKAGE_MANAGER="sudo pacman -S"  # TODO switch to yay?
else
    echo "Please specify the OS ('arch' or 'macOS')"
    exit 1
fi


# INITIAL SETUP
# =============================================================================

if [ "$CLONE_CONFIG_FILES" = true ]; then
    $RICE/setup/default/clone_config_files.sh
fi

if [ "$OS" = "arch" ] && [ "$INITIALIZE_PACMAN" = true ]; then
    $RICE/setup/arch/initialize_pacman.sh
fi

if [ "$OS" = "arch" ] && [ "$SETUP_HOMEDIR" = true ]; then
    $RICE/setup/arch/setup_home_dir.sh
fi

if [ "$OS" = "arch" ] && [ "$INITIALIZE_XORG" = true ]; then
    $RICE/setup/arch/initialize_xorg.sh
fi

if [ "$OS" = "arch" ] && [ "$SETUP_SUCKLESS" = true ]; then
    $RICE/setup/arch/setup_suckless.sh
fi

if [ "$OS" = "macOS" ] && [ "$SETUP_XCODE" = true ]; then
    $RICE/setup/macOS/setup_xcode.sh
fi


# INSTALL PACKAGE MANAGERS  (and version control system)
# =============================================================================

# git
if [ "$INSTALL_GIT" = true ]; then   # TODO
    $RICE/install/default/install_git.sh
fi

# yay  (only if running on arch)
if [ "$OS" = "arch" ] && [ $INSTALL_YAY = true ]; then
    $RICE/install/os_arch/install_yay.sh
fi

# brew  (only if running on macOS)
if [ "$OS" = "macOS" ] && [ $INSTALL_BREW = true ]; then
    $RICE/install/os_macOS/install_brew.sh
fi

# macports  (only if running on macOS)
if [ "$OS" = "macOS" ] && [ $INSTALL_MACPORTS = true ]; then
    $RICE/install/os_macOS/install_macports.sh
fi


# INSTALL PACKAGES
# =============================================================================

# "default" packages     (-> brew or pacman/yay)
if [ "$INSTALL_PKGS" = true ]; then
    $RICE/install/default/install_packages_default.sh
fi

# mac-specfic packages   (-> brew)
if [ "$INSTALL_PKGS" = true ] && [ "$OS" = "macOS" ]; then
    $RICE/install/os_macOS/install_packages_macOS.sh
fi

# arch-specfic packages  (-> pacman/yay)
if [ "$INSTALL_PKGS" = true ] && [ "$OS" = "arch" ]; then
    $RICE/install/os_arch/install_packages_arch.sh
fi

# zsh plugins            (-> ohmyzsh)
if [ "$INSTALL_PKGS_ZSH" = true ]; then
    $RICE/install/zsh/install_packages_zsh.sh
fi

# python packages        (-> pip3)
if [ "$INSTALL_PKGS_PYTHON" = true ]; then
    $RICE/install/python/install_packages_python.sh
fi

# node packages          (-> npm)
if [ "$INSTALL_PKGS_NODE" = true ]; then
    $RICE/install/node/install_packages_node.sh
fi

# nvim plugins           (-> vim-plug + conquer-of-completion)
if [ "$INSTALL_PKGS_NVIM" = true ]; then
    $RICE/install/nvim/install_packages_nvim.sh
fi

# tmux plugins           (-> tpm)
if [ "$INSTALL_PKGS_TMUX" = true ]; then
    $RICE/install/tmux/install_packages_tmux.sh
fi

# ranger plugins
if [ "$INSTALL_PKGS_RANGER" = true ]; then
    $RICE/install/ranger/install_packages_ranger.sh
fi

# rust
if [ "$INSTALL_RUST" = true ]; then
    $RICE/install/default/install_rust.sh
fi

# emacs (+ doom)
if [ "$INSTALL_EMACS_DOOM" = true ]; then
    $RICE/install/default/install_emacs_doom.sh
fi


# CONFIGURE PACKAGES
# =============================================================================

if [ "$CONFIGURE_GIT" = true ]; then
    $RICE/config/git/configure_git.sh
fi

if [ "$CREATE_SYMLINKS" = true ]; then
    $RICE/config/symlinks/create_symlinks.sh
fi


# PULL GIT REPOS
# =============================================================================

if [ "$PULL_GIT_REPOS" = true ]; then
    $RICE/config/git/pull_git_repos.sh
fi

