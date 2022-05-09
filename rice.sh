#!/bin/sh

# =============================================================================
#                              AUTO-RICE SCRIPTS
#                                    V.C.M.
# =============================================================================

#                                 RICE-CONFIG
# =============================================================================

#                                OS-INDEPENDENT
# -----------------------------------------------------------------------------
DO_FULL_SYSTEM_UPGRADE="false"  

INSTALL_EMACS_DOOM="false"      
INSTALL_RUST="false"            
INSTALL_PKGS_TMUX="true"        
INSTALL_PKGS_ZSH="true"         # TODO lock-file
INSTALL_PKGS_RANGER="true"      
INSTALL_PKGS_PYTHON="true"      
INSTALL_PKGS_NODE="false"       
INSTALL_PKGS_NVIM="false"       # not really needed

#                                 ARCH-SPECIFIC
# -----------------------------------------------------------------------------
INSTALL_SUCKLESS="true"

#                                MACOS-SPECIFIC
# -----------------------------------------------------------------------------
SETUP_XCODE="false"             # TODO very unfinished -> test! (at some point) 
UPDATE_SYSTEM="false"           # TODO very unfinished -> test! (at some point) 
UPDATE_CMD_LINE_TOOLS="false"   # TODO very unfinished -> test! (at some point) 

#                                  RICE-SETUP
# =============================================================================

# get info about author & project-name
export AUTHOR="Vincent C. Mader"
export PROJECT_NAME="AUTO-RICE SCRIPTS"
# get user-name
export USER="$(whoami)"
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

# if doing full-system upgrade, clear log-files of already-installed packages
if [ "$DO_FULL_SYSTEM_UPGRADE" = "true" ]; then
    for i in $RICE/package-installation/**/pkgs_*/installed.txt; do
        > $i  # clear file content
    done
fi

# setup printing
source "$RICE/utils/get_colors.sh"
source "$RICE/utils/pretty_printing.sh"
# setup from-pkg-file installer
source "$RICE/utils/get_pkg_manager.sh"
source "$RICE/utils/install_pkgs_from_file.sh"

#                                 MAIN SCRIPT
# =============================================================================
echo_title

#                        PRE-INSTALL INITIALIZATION/SETUP
# =============================================================================
echo_header_l1 "INITIALIZATION"

#               INSTALL PACKAGE MANAGERS & VERSION CONTROL SYSTEM(S)
# -----------------------------------------------------------------------------

INIT_DEFAULT="$RICE/initialization/default"
INIT_ARCH="$RICE/initialization/os_arch"
INIT_MACOS="$RICE/initialization/os_macOS"

    sh "$INIT_DEFAULT/install_git.sh"
    sh "$INIT_DEFAULT/setup_home_dir.sh"
    sh "$INIT_DEFAULT/create_symlinks.sh"
    sh "$INIT_DEFAULT/clone_config_files.sh"

if [ "$OS" = "arch" ]; then
    sh "$INIT_ARCH/initialize_pacman.sh"
    sh "$INIT_ARCH/install_yay.sh"
    sh "$INIT_ARCH/setup_fonts.sh"         # TODO fix for st
    sh "$INIT_ARCH/initialize_xorg.sh"
    sh "$INIT_ARCH/setup_suckless.sh"                         TODO uncomment

elif [ "$OS" = "macOS" ]; then
    sh "$INIT_MACOS/install_brew.sh"
    sh "$INIT_MACOS/install_macports.sh"  # TODO

    if [ "$UPDATE_SYSTEM" = "true" ]; then
        "$RICE/initialization/os_macOS/update_system.sh"
    fi
    if [ "$UPDATE_CMD_LINE_TOOLS" = "true" ]; then
        "$RICE/initialization/os_macOS/update_cmd_line_tools.sh"
    fi
    if [ "$SETUP_XCODE" = "true" ]; then
        "$RICE/initialization/os_macOS/setup_xcode.sh"
    fi
fi

#                               INSTALL PACKAGES
# =============================================================================
echo_header_l1 "PACKAGE INSTALLATION"

"$RICE/package-installation/default/install_packages_default.sh"
if [ "$OS" = "macOS" ]; then   # -> via brew
   "$RICE/package-installation/os_macOS/install_packages_macOS.sh"
elif [ "$OS" = "arch" ]; then  # -> via pacman/yay
    "$RICE/package-installation/os_arch/install_packages_arch.sh"
fi
"$RICE/package-installation/gem/install_packages_gem.sh"

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

#                         POST-INSTALL CONFIGURATION
# =============================================================================
echo_header_l1 "POST-INSTALL CONFIGURATION"

# configure git & pull repos
"$RICE/package-setup/git/configure_git.sh"   # after symlinks
"$RICE/package-setup/git/pull_git_repos.sh"

if [ "$OS" = "macOS" ]; then

    # configure zathura                             TODO make OS-independent
    "$RICE/package-setup/zathura-pdf-mupdf/setup_zathura_pdf_mupdf.sh"

    # configure mactex install                      TODO move to own file?
    echo_header_l2 "Configuring macTeX..."
    eval "$(/usr/libexec/path_helper)"
    echo "Configured macTeX."

    # configure automatic startup-launch of mongod 
    #                                               TODO make OS-independent
    #                                               TODO move to own file?
    echo_header_l2 "Configuring mongodb..."
    brew services start mongodb/brew/mongodb-community > /dev/null
    echo "Started mongod."

    # configure skhd                                TODO auto-start on login?
    echo_header_l2 "Configuring skhd..."
    # brew services start skhd > /dev/null
    printf "$COLOR_YELLOW"
    echo "WARN: This might need manual setup!$COLOR_DEFAULT"
    echo "      Run 'brew services start skhd' to start the daemon."
    echo "      Run 'skhd' to enable the necessary authentifications from System Preferencs!"

    # configure yabai                               TODO auto-start on login?
    echo_header_l2 "Configuring yabai..."
    printf "$COLOR_YELLOW"
    echo "WARN: This might need manual setup!$COLOR_DEFAULT"
    echo "      Follow this guide: https://github.com/koekeishiya/yabai/wiki$COLOR_DEFAULT"

fi

