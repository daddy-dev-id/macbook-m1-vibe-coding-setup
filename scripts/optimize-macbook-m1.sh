#!/bin/bash

# MacBook M1 Optimization Script for Vibe Coding
# This script optimizes MacBook M1 for AI/ML development and vibe coding

set -e

echo "🍎 MacBook M1 Optimization for Vibe Coding"
echo "=========================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if running on M1 Mac
check_m1_mac() {
    print_info "Checking if running on M1 Mac..."
    
    if [[ $(uname -m) == "arm64" ]]; then
        print_status "Running on Apple Silicon (M1/M2/M3)"
        return 0
    else
        print_error "This script is designed for Apple Silicon Macs"
        exit 1
    fi
}

# Check system requirements
check_system_requirements() {
    print_info "Checking system requirements..."
    
    # Check macOS version
    macos_version=$(sw_vers -productVersion)
    print_info "macOS version: $macos_version"
    
    # Check available memory
    memory_gb=$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2}')
    print_info "Available memory: $memory_gb"
    
    # Check available storage
    storage_gb=$(df -h / | awk 'NR==2 {print $4}')
    print_info "Available storage: $storage_gb"
    
    # Check if we have enough resources
    if [[ ${memory_gb%GB} -lt 8 ]]; then
        print_warning "Less than 8GB RAM detected. Some optimizations may be limited."
    fi
}

# Install Homebrew for Apple Silicon
install_homebrew() {
    print_info "Installing Homebrew for Apple Silicon..."
    
    if command -v brew &> /dev/null; then
        print_status "Homebrew already installed"
        brew update
    else
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add to PATH
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

# Install essential development tools
install_development_tools() {
    print_info "Installing essential development tools..."
    
    # Install core tools
    brew install --cask visual-studio-code
    brew install --cask cursor
    brew install --cask iterm2
    brew install --cask docker
    brew install --cask miniconda
    brew install --cask jupyterlab
    
    # Install command line tools
    brew install git
    brew install node@18
    brew install python@3.11
    brew install htop
    brew install tree
    
    print_status "Development tools installed"
}

# Optimize M1 power management
optimize_power_management() {
    print_info "Optimizing M1 power management..."
    
    # Prevent sleep when plugged in
    sudo pmset -c sleep 0
    sudo pmset -c disksleep 0
    sudo pmset -c displaysleep 30
    
    # Conservative battery settings
    sudo pmset -b sleep 15
    sudo pmset -b disksleep 10
    sudo pmset -b displaysleep 5
    
    # Global settings
    sudo pmset -a womp 1
    sudo pmset -a networksleep 0
    sudo pmset -a lidwake 1
    
    # Disable power nap
    sudo pmset -a powernap 0
    sudo pmset -a standby 0
    sudo pmset -a autopoweroff 0
    
    print_status "Power management optimized"
}

# Optimize M1 memory management
optimize_memory_management() {
    print_info "Optimizing M1 memory management..."
    
    # Clear memory caches
    sudo purge
    
    # Optimize virtual memory
    sudo sysctl -w vm.swappiness=10
    sudo sysctl -w vm.vfs_cache_pressure=50
    
    # Increase file descriptor limits
    sudo launchctl limit maxfiles 65536 200000
    
    print_status "Memory management optimized"
}

# Set up M1-optimized Python environment
setup_python_environment() {
    print_info "Setting up M1-optimized Python environment..."
    
    # Initialize conda
    eval "$(/opt/homebrew/bin/conda shell.bash hook)"
    
    # Create vibe-coding environment
    conda create -n vibe-coding python=3.11 -y
    conda activate vibe-coding
    
    # Install M1-optimized packages
    pip install --upgrade pip
    pip install numpy scipy pandas matplotlib seaborn
    pip install jupyter jupyterlab
    pip install scikit-learn
    
    # Install PyTorch for M1
    pip install torch torchvision torchaudio
    
    # Install TensorFlow for M1
    pip install tensorflow-macos tensorflow-metal
    
    # Install additional AI/ML packages
    pip install transformers datasets
    pip install wandb mlflow
    pip install ipywidgets jupyter-dash
    
    print_status "Python environment set up"
}

# Configure VS Code for M1
configure_vscode() {
    print_info "Configuring VS Code for M1..."
    
    # Install essential extensions
    code --install-extension ms-python.python
    code --install-extension ms-toolsai.jupyter
    code --install-extension ms-python.pylint
    code --install-extension ms-python.black-formatter
    code --install-extension github.copilot
    code --install-extension ms-vscode.vscode-json
    code --install-extension ms-python.isort
    code --install-extension ms-toolsai.vscode-ai
    
    # Create VS Code settings directory
    mkdir -p ~/Library/Application\ Support/Code/User
    
    # Create M1-optimized settings
    cat > ~/Library/Application\ Support/Code/User/settings.json << EOF
{
    "python.defaultInterpreterPath": "~/miniconda3/envs/vibe-coding/bin/python",
    "python.terminal.activateEnvironment": true,
    "jupyter.askForKernelRestart": false,
    "jupyter.autoStartDefaultKernel": true,
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.formatting.provider": "black",
    "editor.formatOnSave": true,
    "files.watcherExclude": {
        "**/node_modules/**": true,
        "**/.git/**": true,
        "**/__pycache__/**": true
    },
    "terminal.integrated.gpuAcceleration": "on",
    "workbench.colorTheme": "Default Dark+",
    "editor.fontSize": 14,
    "editor.fontFamily": "SF Mono, Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace"
}
EOF
    
    print_status "VS Code configured for M1"
}

# Set up Docker for M1
setup_docker() {
    print_info "Setting up Docker for M1..."
    
    # Start Docker Desktop
    open -a Docker
    
    # Wait for Docker to start
    print_info "Waiting for Docker to start..."
    sleep 10
    
    # Test M1 support
    if docker run --platform linux/arm64 hello-world &> /dev/null; then
        print_status "Docker M1 support verified"
    else
        print_warning "Docker M1 support test failed. Please check Docker Desktop."
    fi
}

# Create M1 performance monitoring script
create_monitoring_script() {
    print_info "Creating M1 performance monitoring script..."
    
    cat > ~/m1-monitor.sh << 'EOF'
#!/bin/bash

echo "=== MacBook M1 Performance Monitor ==="
echo

# CPU Information
echo "CPU Information:"
sysctl -n machdep.cpu.brand_string
echo "Performance Cores: $(sysctl -n hw.perflevel0.physicalcpu)"
echo "Efficiency Cores: $(sysctl -n hw.perflevel1.physicalcpu)"
echo

# Memory Information
echo "Memory Information:"
system_profiler SPHardwareDataType | grep "Memory:"
echo

# GPU Information
echo "GPU Information:"
system_profiler SPDisplaysDataType | grep -A 5 "Chipset Model"
echo

# Neural Engine
echo "Neural Engine:"
system_profiler SPHardwareDataType | grep -i "neural"
echo

# Current Performance
echo "Current Performance:"
top -l 1 | grep "CPU usage"
top -l 1 | grep "PhysMem"
echo

# Temperature (if available)
echo "Temperature:"
sudo powermetrics --samplers smc -n 1 | grep -i temp
EOF
    
    chmod +x ~/m1-monitor.sh
    print_status "M1 monitoring script created at ~/m1-monitor.sh"
}

# Create vibe coding startup script
create_vibe_coding_script() {
    print_info "Creating vibe coding startup script..."
    
    cat > ~/start-vibe-coding.sh << 'EOF'
#!/bin/bash

echo "🚀 Starting Vibe Coding Environment on M1..."
echo

# Activate conda environment
eval "$(/opt/homebrew/bin/conda shell.bash hook)"
conda activate vibe-coding

# Check M1 performance
echo "M1 Performance Check:"
python3 -c "
import torch
import psutil
import sys

print(f'Python version: {sys.version}')
print(f'PyTorch MPS available: {torch.backends.mps.is_available()}')
print(f'PyTorch MPS built: {torch.backends.mps.is_built()}')
print(f'CPU usage: {psutil.cpu_percent()}%')
print(f'Memory usage: {psutil.virtual_memory().percent}%')

if torch.backends.mps.is_available():
    print('M1 GPU: Available')
    print(f'GPU Memory: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB')
else:
    print('M1 GPU: Not available')
"

echo
echo "✅ Vibe Coding environment ready!"
echo "📊 Run '~/m1-monitor.sh' to check performance"
echo "🔧 Run 'code .' to start VS Code"
echo "📓 Run 'jupyter lab' to start Jupyter Lab"
EOF
    
    chmod +x ~/start-vibe-coding.sh
    print_status "Vibe coding startup script created at ~/start-vibe-coding.sh"
}

# Main optimization function
main() {
    echo "Starting MacBook M1 optimization for vibe coding..."
    echo
    
    check_m1_mac
    check_system_requirements
    install_homebrew
    install_development_tools
    optimize_power_management
    optimize_memory_management
    setup_python_environment
    configure_vscode
    setup_docker
    create_monitoring_script
    create_vibe_coding_script
    
    echo
    echo "🎉 MacBook M1 optimization complete!"
    echo
    echo "Next steps:"
    echo "1. Restart your Mac to apply all settings"
    echo "2. Run '~/start-vibe-coding.sh' to start development"
    echo "3. Run '~/m1-monitor.sh' to check performance"
    echo "4. Open VS Code and start coding!"
    echo
    echo "Happy vibe coding on your M1 Mac! 🚀"
}

# Run main function
main "$@"