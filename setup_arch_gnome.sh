#!/bin/bash
#
# -----------------------------------------------------------------------------
# Troubleshooting:
#
# Can't detect printer:
#   -> Restart avahi:
#       sudo systemctl restart avahi-daemon
#
#   -> Go to: http://localhost:631/admin
#       and install the printer from there
#
# ------------------------------------- configs -------------------------------
# Color Definitions
RED='\033[0;31m'       # Errors
ORANGE='\033[0;33m'    # System information / Title
YELLOW='\033[1;33m'    # Packages
GREEN='\033[0;32m'     # Success
LIGHTBLUE='\033[1;34m' # Configs
NC='\033[0m'           # No Color (reset to default value)

# ------------------------------------- update packages ------------------------
echo -e "${YELLOW}\n\nUpdating packages...${NC}"
sudo pacman -Syu --noconfirm

# ------------------------------------- AUR (yay) -----------------------------
sudo pacman -S yay --noconfirm

# ------------------------------------- Packages ------------------------
apps=(
    # Terminal
    "kitty" # Terminal that runs in the GPU

    # Gnome (and GKT4 apps)
    "baobab" # GTK 4 Disk Usage Analyzer
    # "clapper"         # Video player with buggy UI
    "extension-manager" # GNOME extension manager
    # "fragments"            # GTK 4 frontend for Transmission
    "gdm"                    # GNOME Display Manager
    "gdm-settings"           # GNOME Display Manager settings GUI
    "ghex"                   # GTK4 Hex Editor
    "gnome-backgrounds"      # GNOME default wallpapers
    "gnome-calendar"         # Calendar application
    "gnome-clocks"           # Clock app for time management
    "gnome-color-manager"    # Color management tool
    "gnome-control-center"   # GNOME system settings
    "gnome-disk-utility"     # Disk management tool
    "gnome-font-viewer"      # View and install fonts
    "gnome-keyring"          # Manages passwords and keys
    "gnome-menus"            # GNOME application menus
    "gnome-session"          # Manages GNOME session
    "gnome-settings-daemon"  # Handles various GNOME settings
    "gnome-shell"            # Core part of GNOME desktop
    "gnome-shell-extensions" # Extensions for GNOME Shell
    "gnome-sound-recorder"   # Sound recording tool
    "gnome-sudoku"           # GNOME Sudoku game
    # "gnome-weather"        # Weather app (not included)
    "metadata-cleaner" # Clean metadata from files
    "nautilus"         # GNOME file manager
    "papers"           # PDF viewer
    "resources"        # System monitor tool
    "rnote"            # Note-taking app (alternative to OneNote)
    # "shortwave"      # Internet radio app (not included)
    "showtime" # Video player
    "snapshot" # Screenshot tool

    # Terminal tools
    "bat"                # Better cat alternative with syntax highlighting
    "bluez-obex"         # Needed to send files over bluetooth
    "btop"               # Terminal based system monitor
    "curl"               # Download files
    "eza"                # Colorful ls
    "fish"               # Shell
    "git"                # Distributed version control system
    "keyd"               # Create custom keybindings (with CapsLock in my case)
    "lazygit"            # Git interface for neovim
    "npm"                # Node.js package manager, required for neovim
    "onedrive-abraunegg" # OneDrive support (AUR)
    "onefetch"           # Like fastfetch but for git
    "pnpm"               # Dependency for live-server
    "ripgrep-all"        # Ripgrep, but search in PDFs, E-Books, Office documents, zip, tar.gz, etc.
    "starship"           # Shell prompt
    "tokei"              # Count code lines
    "tealdeer"           # Faster tldr written in rust
    "trash-cli"          # Control trash through terminal
    "tree-sitter-cli"    # Required for latex treesitter
    "wget"               # Download files
    "wl-clipboard"       # Required for neovim to copy to clipboard
    "yarn"               # Node.js package manager
    "yazi"               # Terminal file manager
    "zip"                # zip, zap, zup
    "zoxide"             # Better cd for faster file system navigation

    # Internet
    "firefox"         # Firefox browser
    "localsend-bin"   # Local network file transfer (AirDrop alternative) (AUR)
    "spotify"         # Spotify for Linux (AUR)
    "teams-for-linux" # Teams client for Linux (AUR)
    "thunderbird"     # Thunderbird mail
    "vesktop"         # Discord with plugins and themes (AUR)
    "zapzap"          # qt6-based Whatsapp client for Linux (AUR)
    # There is a GTK4 Whatsapp client called "whakarere" but its still buggy af
    # zapzap is currently the only application (on this gnome-DE) with qt(6) dependencies

    # GUI tools
    "gnome-2048"   # Gnome 2048
    "gnome-tweaks" # Edit gnome
    # "heroic-games-launcher" # OpenSource epic games launcher replacement
    # "lutris"              # Windows game engine (requires wine) (made with qt...)
    "meld" # Compare multiple files
    # "mission-center" # GTK 4 system monitor
    # "piper"            # Logitech mouse support
    "python-pympress"  # PDF Presenter (AUR)
    "qalculate-gtk"    # GUI for the Terminal calculator qalculate with GTK2/3
    "transmission-gtk" # Torrent downloader

    # Gnome shell extensions
    # https://unix.stackexchange.com/questions/617288/command-line-tool-to-install-gnome-shell-extensions

    # Editors
    # "intellij-idea-ultimate-edition"  # Intellij
    "neovim"   # Neovim
    "obsidian" # Obsidian
    # "sublime-text-4"           # Sublime 4
    # "vscodium"                 # VSCode with better privacy
    # "vscodium-git-marketplace" # VSCodium with vscode marketplace
    # "code"                     # Code OSS (basically vscode before MS bullshit added, is available in the extra repo)
    # "visual-studio-code-bin"   # Use this option if you need MS plugins like live preview or ssh
    # "zed"                      # Zeditor

    # Wine
    # "wine"
    # "wine-gecko"
    # "wine-mono"

    # Programming languages and similar stuff
    "clang"          # C/C++ compiler
    "delve"          # Go debugger
    "dotnet-sdk"     # .NET sdk
    "gcc"            # C/C++ compiler
    "gdb"            # Debugger
    "jdk-openjdk"    # Java sdk
    "netcoredbg"     # .NET debugger (AUR)
    "python"         # Python 3
    "python-debugpy" # Python debugger
    "shellcheck"     # Bash linter
    "shfmt"          # Bash formatter

    # Latex
    "texlive" # LaTeX compiler and libraries
    # "texlive-lang"

    # Fun applications
    "asciiquarium" # IS THIS A SHARK?
    # "cmatrix"      # Matrix-like screen saver
    # "cowsay"       # Configurable talking cow
    "fastfetch" # Fast, highly customizable system info script
    # "fortune-mod"  # Prints a random, hopefully interesting, adage
    "nyancat" # FUCKING NYANCAT

    # Themes
    "bibata-cursor-theme" # Bibata cursors (AUR)
    "papirus-icon-theme"
    "adw-gtk-theme"   # GTK4 like theme for GTK2/3 application
    "papirus-folders" # Folder color theme for papirus theme (AUR)
    # "tela-icon-theme-purple-git"
    # "endeavouros-theming" # Needed for GTM-Settings

    # Fonts
    "ttf-firacode-nerd"
)

for tool in "${apps[@]}"; do
    echo -e "${YELLOW}\n\nInstalling $tool...${NC}"
    yay -S "$tool" --noconfirm
done

# ------------------------------------- fonts ---------------------------------
font_links=(
    https://github.com/pjobson/Microsoft-365-Fonts
    # https://github.com/ryanoasis/nerd-fonts # Would install all nerdfonts (is way too large)
    # https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lilex.zip
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
)

for link in "${font_links[@]}"; do
    if [[ "$link" == *.zip ]]; then
        repo_name=$(basename "$link")
        echo -e "${YELLOW}\n\nDownloading $link...${NC}"

        download_path="$HOME/Downloads/$repo_name"

        wget -O "$download_path" "$link"
        unzip -o -d "$HOME/Downloads/${repo_name%.*}" "$download_path"

        move_path="$HOME/Downloads/${repo_name%.*}"
    else
        repo_name=$(basename "${link%/*}") # Removes the last part of URL if it's not a .git repository

        echo -e "${YELLOW}\n\nCloning $link into $HOME/Downloads/$repo_name...${NC}"

        # Clone the repository
        git clone --depth 1 "$link" "$HOME/Downloads/$repo_name" 2>/dev/null || echo -e "${RED}Failed to clone $link. Check if the URL is a full repository.${NC}"

        move_path="$HOME/Downloads/${repo_name%.*}"
    fi

    echo -e "${YELLOW}\n\nMoving fonts to /usr/share/fonts/${NC}"
    sudo cp -r "$move_path" /usr/share/fonts/
done

echo -e "${GREEN}\n\nInstalled fonts${NC}"

# # ------------------------------------- KVM with QEMU -------------------------
# configure_and_start_services() {
#     set +e
#
#     echo -e "${GREEN}\nConfiguring and starting necessary services...${NC}"
#
#     # Start and enable libvirtd.service
#     echo -e "${YELLOW}\nStarting and enabling libvirtd.service...${NC}"
#     sudo systemctl start libvirtd.service
#     sudo systemctl enable libvirtd.service
#
#     # Manage the 'default' network
#     manage_default_network
#
#     set -e
# }
#
# manage_default_network() {
#     defaultNetworkActive=$(sudo virsh net-list --all | grep -w default | grep -w active)
#
#     echo -e "${YELLOW}\nThe 'default' network is not active. Starting it...${NC}"
#     sudo virsh net-start default
#
#     # defaultNetworkAutostart=$(sudo virsh net-list --all | grep -w default | grep -w yes)
#
#     echo -e "${YELLOW}\nSetting the 'default' network to autostart...${NC}"
#     sudo virsh net-autostart default
#
#     # Finally, list all networks to confirm their statuses
#     echo -e "${GREEN}\nCurrent network list:${NC}"
#     sudo virsh net-list --all
# }
#
# echo -e "${YELLOW}\n\nInstalling KVM...${NC}"
# sudo pacman -S virt-manager qemu-full vde2 dnsmasq bridge-utils openbsd-netcat --noconfirm
# configure_and_start_services
#
# # ------------------------------------- Start KVM -----------------------------
# set +e
# echo -e "${ORANGE}\nConfiguring and starting necessary services...${NC}"
#
# # Start and enable libvirtd.service
# echo -e "${LIGHTBLUE}\nStarting and enabling libvirtd.service...${NC}"
# sudo systemctl start libvirtd.service
# sudo systemctl enable libvirtd.service
#
# # Check the 'default' network status more reliably
# defaultNetworkActive=$(sudo virsh net-list --all | grep -w default | grep -w active)
#
# if [ -z "$defaultNetworkActive" ]; then
#     echo -e "${LIGHTBLUE}\nThe 'default' network is not active. Starting it...${NC}"
#     sudo firewall-cmd --reload
#     sudo virsh net-start default
# else
#     echo -e "${ORANGE}\nThe 'default' network is already active.${NC}"
# fi
#
# # Ensure the 'default' network is set to autostart
# defaultNetworkAutostart=$(sudo virsh net-list --all | grep -w default | grep -w yes)
#
# if [ -z "$defaultNetworkAutostart" ]; then
#     echo -e "${LIGHTBLUE}\nSetting the 'default' network to autostart...${NC}"
#     sudo virsh net-autostart default
# else
#     echo -e "${ORANGE}\nThe 'default' network is already set to autostart.${NC}"
# fi
#
# #-------------------------------------- SpotX (ad-blocker) ------------------
# echo -e "${YELLOW}\n\nInstalling SpotX...${NC}"
# bash <(curl -sSL https://spotx-official.github.io/run.sh) -cef # -f -> force rerun if already tried
#
# # Install spicetify
# curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh

#-------------------------------------- Firefox & Thunderbird GTK4 theme ------
echo -e "${YELLOW}\n\nInstalling Firefox GTK4 theme...${NC}"
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash

echo -e "${YELLOW}\n\nInstalling Thunderbird GTK4 theme...${NC}"
git clone https://github.com/rafaelmardojai/thunderbird-gnome-theme && cd thunderbird-gnome-theme
# ------------------------------------- Bluetooth -----------------------------
sudo modprobe btusb
pacman -Ss bluetooth
sudo dmesg | grep -i bluetooth

# Start bluetooth deamon
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
sudo systemctl status bluetooth

# ------------------------------------- advanced touchpad support -------------
# sudo pacman -S touchegg --noconfirm
# systemctl enable touchegg.service
# systemctl start touchegg.service
#
# ------------------------------------- Printer manager -----------------------
# echo -e "${YELLOW}\n\nInstalling CUPS...${NC}"
sudo pacman -S cups --noconfirm

sudo systemctl start cups.service
sudo systemctl enable cups.service

# Restart avahi
sudo systemctl restart avahi-daemon

# ------------------------------------- Nautilus extensions -------------------
yay -S python-nautilus --noconfirm

# Copy path
git clone https://github.com/chr314/nautilus-copy-path.git
cd nautilus-copy-path
make install

# Open any terminal
yay -S nautilus-open-any-terminal # (AUR)

# ------------------------------------- Firefox plugins -----------------------
# Go to https://addons.mozilla.org/en-US/firefox/
# and search for a plugin you want to install.
# Right-click the "Add to Firefox"-Button and copy link

# To get the plugin ID:
#   - go to about:memory
#   - under "Show memory reports" -> Measure
#   - Filter for "moz-extension"

echo -e "${YELLOW}\n\nInstalling Firefox plugins...${NC}"

# Define extension URLs and their IDs
declare -A extensions=(
    # Youtube Dislike
    ["{762f9885-5a13-4abd-9c77-433dcd38b8fd}"]="https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi"

    # Nyan Cat
    ["{c3348e96-6d84-47dc-8252-4b8493299efc}"]="https://addons.mozilla.org/firefox/downloads/file/3975526/nyan_cat_youtube_enhancement-3.0.xpi"

    # Vimium
    ["{d7742d87-e61d-4b78-b8a1-b469842139fa}"]="https://addons.mozilla.org/firefox/downloads/file/4259790/vimium_ff-2.1.2.xpi"

    # ["vimium-c@gdh1995.cn"]="https://addons.mozilla.org/firefox/downloads/file/4210117/vimium_c-1.99.997.xpi"

    # Dark Reader
    ["addon@darkreader.org"]="https://addons.mozilla.org/firefox/downloads/file/4249607/darkreader-4.9.80.xpi"

    # UBlock Origin
    ["uBlock0@raymondhill.net"]="https://addons.mozilla.org/firefox/downloads/file/4237670/ublock_origin-1.56.0.xpi"

    # WideGPT
    ["widegpt@cstone"]="https://addons.mozilla.org/firefox/downloads/file/4224810/widegpt-1.14.xpi"

    # Bitwarden
    ["{446900e4-71c2-419f-a6a7-df9c091e268b}"]="https://addons.mozilla.org/firefox/downloads/file/4326285/bitwarden_password_manager-2024.7.1.xpi"

    # CookieAutoDelete
    ["CookieAutoDelete@kennydo.com"]="https://addons.mozilla.org/firefox/downloads/file/4040738/cookie_autodelete-3.8.2.xpi"

)

# Ensure the Firefox distribution extensions directory exists
firefox_dist_path="/lib/firefox/distribution/extensions" && sudo mkdir -p "$firefox_dist_path"

# Loop through the extensions array and process each item
for id in "${!extensions[@]}"; do
    url="${extensions[$id]}"
    file_name=$(basename "$url")
    save_path="$firefox_dist_path/$id.xpi"
    echo "Downloading and installing $file_name with ID $id"
    # Download the .xpi file using its ID as the file name
    sudo wget -O "$save_path" "$url" && echo "Installed $file_name to $save_path"
done

echo -e "${GREEN}\nAll extensions have been downloaded and extracted.${NC}"

# ------------------------------------- Configure Git -------------------------
set +e

echo -e "${ORANGE}\n\nPlease configure Git user name and email:${NC}"

# Check if a Git user name is already set
existingGitUserName=$(git config --global user.name)
if [ -n "$existingGitUserName" ]; then
    echo "Current Git user name is: $existingGitUserName"
    read -rp "Do you want to keep this user name? (y/n): " keepUserName

    if [ "$keepUserName" != "y" ]; then
        read -rp "Enter new Git user name: " gitUserName
        git config --global user.name "$gitUserName"
    fi
else
    read -rp "Enter Git user name: " gitUserName
    git config --global user.name "$gitUserName"
fi

# Check if a Git email is already set
existingGitEmail=$(git config --global user.email)
if [ -n "$existingGitEmail" ]; then
    echo "Current Git email is: $existingGitEmail"
    read -rp "Do you want to keep this email? (y/n): " keepEmail

    if [ "$keepEmail" != "y" ]; then
        read -rp "Enter new Git email: " gitEmail
        git config --global user.email "$gitEmail"
    fi
else
    read -rp "Enter Git email: " gitEmail
    git config --global user.email "$gitEmail"
fi

set -e

# ------- Remove undesired preinstalled (endeavour) gnome applications -------
sudo pacman -Rdd stoken --noconfirm

remove_apps=(
    #     "gnome-calculator"
    #     "gnome-console"
    #     "gnome-nettool"
    #     "gnome-power-manager"
    #     "gnome-screenshot"
    #     "gnome-system-monitor"
    #     "gnome-terminal"
    #     "gnome-text-editor"
    #     "gnome-usage"
    "pavucontrol"
    #     "totem"
    "xterm"
)

for tool in "${remove_apps[@]}"; do
    echo -e "${YELLOW}\n\nInstalling $tool...${NC}"
    yay -Runs "$tool" --noconfirm
done

# ------------------------------------- Services ------------------------------
sudo systemctl enable --now gdm.service

# ------------------------------------- Other ---------------------------------
# Use wayland instead of X11 for electron apps
# Use the update_electron.sh script

# Enable review option to yay
yay --editmenu --save

# Cleanup cache
yay -Scc --noconfirm

# Enable fractional scaling
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

# Change default shell
chsh -s /bin/fish

# Create symlinks
# Apparently the default terminal is hard-coded (wtf?), so the only way AFAIK
# to change the default terminal is to create a symlink
sudo ln -s /usr/bin/kitty /usr/bin/gnome-console
sudo ln -s /usr/bin/kitty /usr/bin/gnome-terminal

# Reboot
echo -e "${GREEN}done${NC}"
echo -e "${YELLOW}Rebooting in 10 seconds...${NC}"
sleep 10
reboot

### Gnome extensions
# Blur my Shell
# Caffeine
# Color Picker
# Dash to Dock
# Media Controls
# Quick Settings Audio Devices Renamer
# Unblank lock screen
# Vitals
# appindicator
# tiling shell
