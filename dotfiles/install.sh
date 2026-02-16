#!/usr/bin/env bash

# Dotfiles Installation Script
# This script intelligently merges configuration files to avoid duplicates

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to print colored messages
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_header() {
    echo -e "\n${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}\n"
}

# Function to backup existing file
backup_file() {
    local file="$1"
    if [ -f "$file" ] || [ -L "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Creating backup: $backup"
        cp "$file" "$backup"
        return 0
    fi
    return 1
}

# Function to merge Fish config
merge_fish_config() {
    local src="$SCRIPT_DIR/config.fish"
    local dest="$HOME/.config/fish/config.fish"

    if [ ! -f "$src" ]; then
        print_warning "config.fish not found, skipping..."
        return
    fi

    # Create directory if needed
    mkdir -p "$(dirname "$dest")"

    if [ ! -f "$dest" ]; then
        print_info "No existing Fish config found, copying new config..."
        cp "$src" "$dest"
        print_success "Fish config installed"
        return
    fi

    print_info "Merging Fish configuration..."
    backup_file "$dest"

    # Create a temporary file for the merged config
    local temp_file=$(mktemp)

    # Copy existing config
    cat "$dest" > "$temp_file"

    # Extract and merge functions
    echo "" >> "$temp_file"
    echo "# ============================================================================" >> "$temp_file"
    echo "# Merged from dotfiles $(date +%Y-%m-%d)" >> "$temp_file"
    echo "# ============================================================================" >> "$temp_file"

    # Add functions if they don't exist
    if ! grep -q "function gitignore" "$dest"; then
        if grep -q "function gitignore" "$src"; then
            print_info "Adding gitignore function..."
            echo "" >> "$temp_file"
            grep -A 2 "function gitignore" "$src" >> "$temp_file"
        fi
    fi

    # Add environment variables if they don't exist
    if ! grep -q "WORKSPACE" "$dest"; then
        print_info "Adding WORKSPACE variable..."
        echo "" >> "$temp_file"
        echo "set -xg WORKSPACE \$HOME/Projects" >> "$temp_file"
    fi

    if ! grep -q "USE_BUILTIN_RIPGREP" "$dest"; then
        print_info "Adding USE_BUILTIN_RIPGREP variable..."
        echo "set -xg USE_BUILTIN_RIPGREP 0" >> "$temp_file"
    fi

    # Add aliases that don't exist
    local aliases=(
        "alias addsshmac="
        "alias bf="
        "alias cat="
        "alias du="
        "alias fzfp="
        "alias l="
        "alias g="
        "alias lg="
        "alias v="
    )

    for alias_pattern in "${aliases[@]}"; do
        if ! grep -q "$alias_pattern" "$dest"; then
            local alias_line=$(grep "$alias_pattern" "$src")
            if [ -n "$alias_line" ]; then
                print_info "Adding alias: $alias_pattern..."
                echo "$alias_line" >> "$temp_file"
            fi
        fi
    done

    mv "$temp_file" "$dest"
    print_success "Fish config merged successfully"
}

# Function to merge gitconfig
merge_gitconfig() {
    local src="$SCRIPT_DIR/gitconfig"

    if [ ! -f "$src" ]; then
        print_warning "gitconfig not found, skipping..."
        return
    fi

    print_info "Merging Git configuration..."

    # Backup if exists
    if [ -f "$HOME/.gitconfig" ]; then
        backup_file "$HOME/.gitconfig"
    fi

    # Use git config commands to set values (this automatically merges)
    print_info "Setting Git user information..."
    git config --global user.name "Salar Rahmanian" || true
    git config --global user.email "code@softinio.com" || true

    print_info "Setting Git core preferences..."
    git config --global core.editor "nvim" || true
    git config --global core.excludesfile "~/.gitignore_global" || true

    print_info "Setting Git init preferences..."
    git config --global init.defaultBranch "main" || true

    print_info "Setting Git fetch/pull preferences..."
    git config --global fetch.prune "true" || true
    git config --global pull.rebase "true" || true

    print_info "Setting Git diff preferences..."
    git config --global diff.colorMoved "default" || true
    git config --global diff.external "difft" || true
    git config --global diff.tool "difftastic" || true

    print_info "Setting Git merge preferences..."
    git config --global merge.tool "nvim" || true
    git config --global mergetool.keepBackup "false" || true
    git config --global mergetool.nvim.cmd 'nvim -d "$LOCAL" "$REMOTE" "$MERGED" -c "wincmd w" -c "wincmd J"' || true
    git config --global mergetool.nvim.trustExitCode "true" || true

    # Set aliases
    print_info "Setting Git aliases..."
    git config --global alias.ci "commit" || true
    git config --global alias.cim "commit -m" || true
    git config --global alias.cia "commit -am" || true
    git config --global alias.co "checkout" || true
    git config --global alias.cob "checkout -b" || true
    git config --global alias.di "diff" || true
    git config --global alias.gpo "push origin" || true
    git config --global alias.main "checkout main" || true
    git config --global alias.master "checkout master" || true
    git config --global alias.st "status" || true

    # Git LFS
    print_info "Configuring Git LFS..."
    git config --global filter.lfs.clean "git-lfs clean -- %f" || true
    git config --global filter.lfs.smudge "git-lfs smudge -- %f" || true
    git config --global filter.lfs.process "git-lfs filter-process" || true
    git config --global filter.lfs.required "true" || true

    print_success "Git config merged successfully"
}

# Function to merge gitignore_global
merge_gitignore() {
    local src="$SCRIPT_DIR/gitignore_global"
    local dest="$HOME/.gitignore_global"

    if [ ! -f "$src" ]; then
        print_warning "gitignore_global not found, skipping..."
        return
    fi

    if [ ! -f "$dest" ]; then
        print_info "No existing global gitignore found, copying new one..."
        cp "$src" "$dest"
        print_success "Global gitignore installed"
        return
    fi

    print_info "Merging global gitignore..."
    backup_file "$dest"

    # Read source patterns and add if not present
    while IFS= read -r line; do
        # Skip empty lines and comments that already explain things
        if [[ -z "$line" ]] || [[ "$line" =~ ^#.*$ ]]; then
            continue
        fi

        # Add pattern if it doesn't exist
        if ! grep -qF "$line" "$dest"; then
            echo "$line" >> "$dest"
        fi
    done < "$src"

    print_success "Global gitignore merged successfully"
}

# Function to install/merge jujutsu config
merge_jj_config() {
    local src="$SCRIPT_DIR/jj-config.toml"
    local dest="$HOME/.config/jj/config.toml"

    if [ ! -f "$src" ]; then
        print_warning "jj-config.toml not found, skipping..."
        return
    fi

    mkdir -p "$(dirname "$dest")"

    if [ ! -f "$dest" ]; then
        print_info "No existing jujutsu config found, copying new config..."
        cp "$src" "$dest"
        print_success "Jujutsu config installed"
        return
    fi

    print_info "Jujutsu config already exists"
    backup_file "$dest"

    read -p "$(echo -e ${YELLOW}Replace existing jj config? [y/N]:${NC} )" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$src" "$dest"
        print_success "Jujutsu config replaced"
    else
        print_info "Keeping existing jj config (backup created)"
    fi
}

# Function to install/merge wezterm config
merge_wezterm_config() {
    local src="$SCRIPT_DIR/wezterm.lua"
    local dest="$HOME/.config/wezterm/wezterm.lua"

    if [ ! -f "$src" ]; then
        print_warning "wezterm.lua not found, skipping..."
        return
    fi

    mkdir -p "$(dirname "$dest")"

    if [ ! -f "$dest" ]; then
        print_info "No existing WezTerm config found, copying new config..."
        cp "$src" "$dest"
        print_success "WezTerm config installed"
        return
    fi

    print_info "WezTerm config already exists"
    backup_file "$dest"

    read -p "$(echo -e ${YELLOW}Replace existing WezTerm config? [y/N]:${NC} )" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$src" "$dest"
        print_success "WezTerm config replaced"
    else
        print_info "Keeping existing WezTerm config (backup created)"
    fi
}

# Function to check if Fisher is installed
check_fisher() {
    if fish -c "type -q fisher" 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to install Fisher
install_fisher() {
    print_info "Installing Fisher (Fish plugin manager)..."

    if ! command -v fish &> /dev/null; then
        print_error "Fish shell is not installed. Please install it first."
        return 1
    fi

    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

    if check_fisher; then
        print_success "Fisher installed successfully"
        return 0
    else
        print_error "Failed to install Fisher"
        return 1
    fi
}

# Function to install Fish plugins
install_fish_plugins() {
    print_info "Installing Fish plugins..."

    # Install bobthefish theme
    print_info "Installing bobthefish theme..."
    fish -c "fisher install oh-my-fish/theme-bobthefish"

    # Install fish-ssh-agent
    print_info "Installing fish-ssh-agent..."
    fish -c "fisher install danhper/fish-ssh-agent"

    print_success "Fish plugins installed"
}

# Main installation function
main() {
    print_header "Dotfiles Installation Script"

    # Check if we're in the dotfiles directory
    if [ ! -f "$SCRIPT_DIR/config.fish" ]; then
        print_error "This script must be run from the dotfiles directory"
        exit 1
    fi

    print_info "This script will intelligently merge configurations, avoiding duplicates."
    print_info "Backups will be created for existing files."
    echo ""

    # Merge Fish config
    merge_fish_config

    # Merge Git config
    merge_gitconfig

    # Merge global gitignore
    merge_gitignore

    # Merge/install jujutsu config
    merge_jj_config

    # Merge/install WezTerm config
    merge_wezterm_config

    echo ""
    print_success "Configuration files processed successfully!"
    echo ""

    # Ask about Fisher and plugins
    if command -v fish &> /dev/null; then
        read -p "$(echo -e ${BLUE}Do you want to install/configure Fish plugins? [y/N]:${NC} )" -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Check if Fisher is installed
            if check_fisher; then
                print_success "Fisher is already installed"
            else
                print_warning "Fisher is not installed"
                read -p "$(echo -e ${BLUE}Install Fisher? [y/N]:${NC} )" -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    install_fisher
                fi
            fi

            # Install plugins if Fisher is available
            if check_fisher; then
                read -p "$(echo -e ${BLUE}Install Fish plugins (bobthefish theme, fish-ssh-agent)? [y/N]:${NC} )" -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    install_fish_plugins
                fi
            fi
        fi
    else
        print_warning "Fish shell not found. Skipping Fish plugin installation."
    fi

    print_header "Installation Complete!"
    print_info "Summary:"
    echo "  • Fish config: Merged functions, aliases, and settings"
    echo "  • Git config: Merged settings using git config commands"
    echo "  • Global gitignore: Merged ignore patterns"
    echo "  • Jujutsu/WezTerm: Installed or skipped based on your choice"
    echo ""
    print_info "Backups of existing files were created with .backup.TIMESTAMP extension"
    print_info "You may need to restart your terminal or run: source ~/.config/fish/config.fish"
    echo ""
}

# Run main function
main
