#!/bin/sh

# =============================================================================
#                              AUTO-RICE SCRIPTS
#                                    V.C.M.
# =============================================================================


# RICE-CONFIG
# =============================================================================

DO_FULL_SYSTEM_UPGRADE="false"     # 

# ARCH-SPECIFIC
SETUP_HOMEDIR="false"           # works! (TODO change wallpaper dir)
SETUP_SUCKLESS="true"          # works! (TODO only half-way though)
INITIALIZE_XORG="true"          # TODO test
SETUP_FONTS="false"
# MACOS-SPECIFIC
SETUP_XCODE="false"             # TODO very unfinished -> test! (at some point) 
UPDATE_SYSTEM="false"           # TODO very unfinished -> test! (at some point) 
UPDATE_CMD_LINE_TOOLS="false"   # TODO very unfinished -> test! (at some point) 

# PACKAGE_INSTALLATION
INSTALL_EMACS_DOOM="false"      # works (?)
INSTALL_RUST="false"            # works (?)
INSTALL_PKGS_NVIM="false"       # works!
INSTALL_PKGS_TMUX="false"       # works!
INSTALL_PKGS_ZSH="false"        # works! (TODO lock-file)
INSTALL_PKGS_RANGER="false"     # works!
INSTALL_PKGS_PYTHON="false"     # works!
INSTALL_PKGS_NODE="false"       # works!


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
            echo "$COLOR_BLUE**$COLOR_DEFAULT $line"
        else 
            echo "$COLOR_GREEN++$COLOR_DEFAULT $line"
            $1 "$line"  # run installer-function passed as 1st argument
            echo "$line" >> "$ALREADY_INSTALLED"
        fi
    done
}
export -f install_from_pkg_file

function echo_separator {
    CHAR="$1"
    SEPARATOR="$COLOR_BLUE"
    for (( col_idx=1; col_idx<=$(tput cols); col_idx++ )); do
        SEPARATOR="$SEPARATOR$CHAR"
    done
    SEPARATOR="$SEPARATOR$COLOR_DEFAULT"
    echo $SEPARATOR
}
export SEPARATOR_1=$(echo_separator "-")
export SEPARATOR_2=$(echo_separator "=")

function echo_title {
    echo "\n$SEPARATOR_1"
    AUTHOR="Vincent C. Mader"
    PROJECT_NAME="AUTO-RICE SCRIPTS"
    printf "$COLOR_BLUE$PROJECT_NAME$COLOR_DEFAULT"

    START_IDX=0
    END_IDX=$(( $(tput cols) - ${#PROJECT_NAME} - ${#AUTHOR} - 1 ))
    for (( col_idx=$START_IDX; col_idx<=$END_IDX; col_idx++ )); do
        printf " "
    done

    printf "$COLOR_BLUE$AUTHOR$COLOR_DEFAULT"
    echo "\n$SEPARATOR_1"
}


# MAIN SCRIPT
# =============================================================================
echo_title

# PRE-INSTALL INITIALIZATION/SETUP
# =============================================================================
echo "\n$SEPARATOR_2$COLOR_BLUE\nINITIALIZATION$COLOR_DEFAULT\n$SEPARATOR_2"

# INSTALL PACKAGE MANAGERS & VERSION CONTROL SYSTEM(S)
# -----------------------------------------------------------------------------

# [X] install git version control system
"$RICE/initialization/default/install_git.sh"

# [ ] arch-specific initialization
if [ "$OS" = "arch" ]; then

    # [ ] initialize pacman          TODO: test
    "$RICE/initialization/os_arch/initialize_pacman.sh"

    # [ ] install yay                TODO: test
    "$RICE/initialization/os_arch/install_yay.sh"

# [X] macOS-specific initialization
elif [ "$OS" = "macOS" ]; then

    # [X] install brew 
    "$RICE/initialization/os_macOS/install_brew.sh"

    # [ ] install macports
    "$RICE/initialization/os_macOS/install_macports.sh"

fi


# PERSONAL FILES
# -----------------------------------------------------------------------------

# [ ] setup home directory
if [ "$OS" = "arch" ] && [ "$SETUP_HOMEDIR" = "true" ]; then
    "$RICE/initialization/os_arch/setup_home_dir.sh"
fi

# [ ] clone config-dotfiles
"$RICE/initialization/default/clone_config_files.sh"

# [X] create symlinks
"$RICE/initialization/symlinks/create_symlinks.sh"

# OS-SPECIFIC: ARCH LINUX
# -----------------------------------------------------------------------------

if [ "$OS" = "arch" ]; then

#     # [ ] download/setup fonts
#     if [ "$SETUP_FONTS" = "true" ]; then
#         "$RICE/initialization/os_arch/setup_fonts.sh"
#     fi
    
    # [ ] setup suckless software (dwm + st + dmenu + tabbed (TODO))
    if [ "$SETUP_SUCKLESS" = "true" ]; then
        "$RICE/initialization/os_arch/setup_suckless.sh"
    fi
    
    # [ ] initialize xorg
    if [ "$INITIALIZE_XORG" = "true" ]; then
        "$RICE/initialization/os_arch/initialize_xorg.sh"
    fi

fi

# # OS-SPECIFIC: MAC OS
# # -----------------------------------------------------------------------------

# if [ "$OS" = "macOS" ]; then

#     # [ ] perform macOS system update
#     if [ "$UPDATE_SYSTEM" = "true" ]; then
#         "$RICE/initialization/os_macOS/update_system.sh"
#     fi
    
#     # [ ] perform macOS cmd-line-tools update
#     if [ "$UPDATE_CMD_LINE_TOOLS" = "true" ]; then
#         "$RICE/initialization/os_macOS/update_cmd_line_tools.sh"
#     fi
    
#     # [ ] setup xcode
#     if [ "$SETUP_XCODE" = "true" ]; then
#         "$RICE/initialization/os_macOS/setup_xcode.sh"
#     fi

# fi


# INSTALL PACKAGES
# =============================================================================
echo "\n\n$SEPARATOR_2$COLOR_BLUE\nPACKAGE INSTALLATION\n$COLOR_DEFAULT$SEPARATOR_2"

# [X] os-independent packages    -> via brew or pacman/yay
# "$RICE/package-installation/default/install_packages_default.sh"
# if [ "$OS" = "macOS" ]; then   # -> via brew
#    "$RICE/package-installation/os_macOS/install_packages_macOS.sh"
# elif [ "$OS" = "arch" ]; then  # -> via pacman/yay
#     "$RICE/package-installation/os_arch/install_packages_arch.sh"
# fi
# "$RICE/package-installation/gem/install_packages_gem.sh"

# # zsh plugins            (-> via ohmyzsh)
# if [ "$INSTALL_PKGS_ZSH" = "true" ]; then
#     "$RICE/package-installation/zsh/install_packages_zsh.sh"
# fi

# # python packages        (-> via pip3)
# if [ "$INSTALL_PKGS_PYTHON" = "true" ]; then
#     "$RICE/package-installation/python/install_packages_python.sh"
# fi

# # node packages          (-> via npm)
# if [ "$INSTALL_PKGS_NODE" = "true" ]; then
#     "$RICE/package-installation/node/install_packages_node.sh"
# fi

# # nvim plugins           (-> via vim-plug + conquer-of-completion)
# if [ "$INSTALL_PKGS_NVIM" = "true" ]; then
#     "$RICE/package-installation/nvim/install_packages_nvim.sh"
# fi

# # tmux plugins           (-> via tpm)
# if [ "$INSTALL_PKGS_TMUX" = "true" ]; then
#     "$RICE/package-installation/tmux/install_packages_tmux.sh"
# fi

# # ranger plugins         (-> via git)
# if [ "$INSTALL_PKGS_RANGER" = "true" ]; then
#     "$RICE/package-installation/ranger/install_packages_ranger.sh"
# fi

# # rust                   (-> via installer script)
# if [ "$INSTALL_RUST" = "true" ]; then
#     "$RICE/package-installation/default/install_rust.sh"
# fi

# # emacs (+ doom)
# if [ "$INSTALL_EMACS_DOOM" = "true" ]; then
#     "$RICE/package-installation/default/install_emacs_doom.sh"
# fi


# # POST-INSTALL CONFIGURATION
# # =============================================================================
# echo "\n\n$SEPARATOR_2$COLOR_BLUE\nPOST-INSTALL CONFIGURATION\n$COLOR_DEFAULT$SEPARATOR_2"

# # configure git
# "$RICE/package-setup/git/configure_git.sh"

# # pull git repos
# "$RICE/package-setup/git/pull_git_repos.sh"

# if [ $OS = "macOS" ]; then

#     # configure zathura       # TODO make this system-independent
#     "$RICE/package-setup/zathura-pdf-mupdf/setup_zathura_pdf_mupdf.sh"

#     # configure mactex install  TODO move to own file?
#     echo "$COLOR_BLUE\nConfiguring macTeX...$COLOR_DEFAULT"
#     eval "$(/usr/libexec/path_helper)"
#     echo "Configured macTeX."

#     # configure automatic startup-launch of mongod 
#     # TODO make this system-independent
#     # TODO move to own file/
#     echo "$COLOR_BLUE\nConfiguring mongodb...$COLOR_DEFAULT"
#     brew services start mongodb/brew/mongodb-community > /dev/null
#     echo "Started mongod."

#     # configure skhd  TODO auto-start on login?
#     echo "$COLOR_BLUE\nConfiguring skhd...$COLOR_DEFAULT"
#     # brew services start skhd > /dev/null
#     echo "$COLOR_YELLOW> WARN: This might need manual setup!"
#     echo "        Run 'brew services start skhd' to start the daemon."
#     echo "        Run 'skhd' to enable the necessary authentifications from System Preferencs!"
#     # echo "Started skhd."

#     # configure yabai # TODO auto-start on login?
#     echo "$COLOR_BLUE\nConfiguring yabai...$COLOR_DEFAULT"
#     echo "$COLOR_YELLOW> WARN: This might need manual setup!"
#     echo "        Follow this guide: https://github.com/koekeishiya/yabai/wiki$COLOR_DEFAULT"

# fi


