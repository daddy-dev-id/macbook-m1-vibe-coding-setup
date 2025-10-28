#!/bin/bash
# MacBook Air M1 Vibe Coding Development Setup
# Optimized for 8GB RAM and maximum performance

echo "🚀 Setting up MacBook Air M1 for vibe coding..."

# Install essential development tools
echo "📦 Installing essential development tools..."

# Node.js version management
if ! command -v fnm &> /dev/null; then
    echo "Installing FNM (Fast Node Manager)..."
    brew install fnm
fi

# Python development tools
if ! command -v pip3 &> /dev/null; then
    echo "Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
fi

# Essential Python packages for development
echo "Installing Python development packages..."
pip3 install --user virtualenv pipenv black flake8

# Essential Node.js packages
echo "Installing Node.js development packages..."
npm install -g @types/node typescript ts-node nodemon

# Git configuration
echo "Configuring Git..."
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "zed"

# Create development directories
echo "Creating development directories..."
mkdir -p ~/Workspace/{projects,experiments,learning}
mkdir -p ~/Workspace/projects/{saas,web,ai,mobile}

# Install essential VS Code extensions (if using VS Code)
if command -v code &> /dev/null; then
    echo "Installing essential VS Code extensions..."
    code --install-extension ms-python.python
    code --install-extension ms-vscode.vscode-typescript-next
    code --install-extension bradlc.vscode-tailwindcss
    code --install-extension esbenp.prettier-vscode
fi

# Set up shell configuration
echo "Setting up shell configuration..."
if [ -f ~/.zshrc_optimized ]; then
    cp ~/.zshrc_optimized ~/.zshrc
    echo "✅ Optimized zsh configuration applied"
fi

# Set up Cursor CLI configuration
if [ -f ~/.cursor_cli_config ]; then
    echo "source ~/.cursor_cli_config" >> ~/.zshrc
    echo "✅ Cursor CLI configuration added"
fi

# Memory optimization
echo "Applying memory optimizations..."
# Disable unnecessary macOS features
sudo pmset -a standby 0
sudo pmset -a hibernatemode 0
sudo pmset -a autopoweroff 0

# Set up swap optimization
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf

echo "🎉 MacBook Air M1 vibe coding setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Restart your terminal to apply shell changes"
echo "2. Use 'zed' as your primary editor"
echo "3. Use 'cursor' CLI for AI assistance"
echo "4. Monitor memory with 'mem' and 'topmem' commands"
echo "5. Consider setting up MCP servers on Proxmox for heavy tasks"