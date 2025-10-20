#!/bin/bash
# Vibe Coding Guide - ML Environment Setup Script
# For Senior Engineers transitioning to AI/ML

set -e

echo "🎵 Setting up Vibe Coding ML Environment..."
echo "=============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if conda is installed
check_conda() {
    if command -v conda &> /dev/null; then
        print_success "Conda is already installed"
        return 0
    else
        print_warning "Conda not found. Installing Miniconda..."
        return 1
    fi
}

# Install Miniconda
install_conda() {
    print_status "Installing Miniconda..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
        bash Miniconda3-latest-MacOSX-x86_64.sh -b -p $HOME/miniconda3
        rm Miniconda3-latest-MacOSX-x86_64.sh
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
        bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
        rm Miniconda3-latest-Linux-x86_64.sh
    else
        print_error "Unsupported OS. Please install Miniconda manually."
        exit 1
    fi
    
    # Add conda to PATH
    echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.zshrc
    export PATH="$HOME/miniconda3/bin:$PATH"
    
    print_success "Miniconda installed successfully"
}

# Create ML development environment
create_ml_environment() {
    print_status "Creating ML development environment..."
    
    # Create conda environment
    conda create -n ml-dev python=3.9 -y
    
    # Activate environment
    source $HOME/miniconda3/etc/profile.d/conda.sh
    conda activate ml-dev
    
    print_success "ML environment created"
}

# Install essential packages
install_packages() {
    print_status "Installing essential AI/ML packages..."
    
    # Activate environment
    source $HOME/miniconda3/etc/profile.d/conda.sh
    conda activate ml-dev
    
    # Core data science stack
    print_status "Installing core data science packages..."
    pip install pandas numpy matplotlib seaborn plotly
    
    # Machine learning
    print_status "Installing machine learning packages..."
    pip install scikit-learn xgboost lightgbm
    
    # Deep learning (PyTorch)
    print_status "Installing PyTorch..."
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
    
    # Jupyter and development tools
    print_status "Installing development tools..."
    pip install jupyter jupyterlab ipywidgets jupyter-dash
    
    # Experiment tracking
    print_status "Installing experiment tracking tools..."
    pip install wandb mlflow
    
    # Additional useful packages
    print_status "Installing additional packages..."
    pip install tqdm requests beautifulsoup4
    
    print_success "All packages installed successfully"
}

# Install VS Code extensions
install_vscode_extensions() {
    print_status "Installing VS Code extensions..."
    
    if command -v code &> /dev/null; then
        # Essential Python extensions
        code --install-extension ms-python.python
        code --install-extension ms-toolsai.jupyter
        code --install-extension ms-python.pylint
        code --install-extension ms-python.black-formatter
        code --install-extension ms-python.isort
        
        # AI/ML specific extensions
        code --install-extension ms-toolsai.vscode-ai
        code --install-extension github.copilot
        
        # Additional useful extensions
        code --install-extension ms-vscode.vscode-json
        code --install-extension ms-python.flake8
        
        print_success "VS Code extensions installed"
    else
        print_warning "VS Code not found. Please install VS Code and run the extensions manually."
    fi
}

# Create project structure
create_project_structure() {
    print_status "Creating project structure..."
    
    # Create directories
    mkdir -p data/{raw,processed,external}
    mkdir -p notebooks
    mkdir -p src/{data,models,training,evaluation}
    mkdir -p models
    mkdir -p experiments
    mkdir -p tests
    mkdir -p docs
    
    # Create example files
    cat > requirements.txt << EOF
# Core data science
pandas>=1.5.0
numpy>=1.21.0
matplotlib>=3.5.0
seaborn>=0.11.0
plotly>=5.0.0

# Machine learning
scikit-learn>=1.1.0
xgboost>=1.6.0
lightgbm>=3.3.0

# Deep learning
torch>=1.12.0
torchvision>=0.13.0
torchaudio>=0.12.0

# Development tools
jupyter>=1.0.0
jupyterlab>=3.4.0
ipywidgets>=7.7.0

# Experiment tracking
wandb>=0.13.0
mlflow>=1.28.0

# Additional tools
tqdm>=4.64.0
requests>=2.28.0
beautifulsoup4>=4.11.0
EOF

    cat > environment.yml << EOF
name: ml-dev
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.9
  - pip
  - pip:
    - -r requirements.txt
EOF

    cat > .gitignore << EOF
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Jupyter Notebook
.ipynb_checkpoints

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# AI/ML specific
*.pkl
*.h5
*.hdf5
*.bin
*.model
*.weights
*.pt
*.pth
*.ckpt

# Data files
data/raw/
data/processed/
*.csv
*.json
*.parquet

# Model outputs
models/
outputs/
results/
logs/
runs/
wandb/
mlruns/

# VS Code
.vscode/

# macOS
.DS_Store

# Windows
Thumbs.db

# Linux
*~
EOF

    print_success "Project structure created"
}

# Create example notebook
create_example_notebook() {
    print_status "Creating example notebook..."
    
    cat > notebooks/01-getting-started.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Getting Started with AI/ML\n",
    "\n",
    "Welcome to your AI/ML journey! This notebook will help you get started with the basics."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Import essential libraries\n",
    "import pandas as pd\n",
    "import numpy as np\n",
    "import matplotlib.pyplot as plt\n",
    "import seaborn as sns\n",
    "from sklearn.model_selection import train_test_split\n",
    "from sklearn.metrics import accuracy_score\n",
    "import torch\n",
    "import torch.nn as nn\n",
    "\n",
    "print(\"All libraries imported successfully!\")\n",
    "print(f\"PyTorch version: {torch.__version__}\")\n",
    "print(f\"Pandas version: {pd.__version__}\")\n",
    "print(f\"NumPy version: {np.__version__}\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Check if GPU is available\n",
    "device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')\n",
    "print(f\"Using device: {device}\")\n",
    "\n",
    "if torch.cuda.is_available():\n",
    "    print(f\"GPU: {torch.cuda.get_device_name(0)}\")\n",
    "    print(f\"GPU Memory: {torch.cuda.get_device_properties(0).total_memory / 1024**3:.2f} GB\")\n",
    "else:\n",
    "    print(\"No GPU available. Using CPU.\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Create sample data\n",
    "np.random.seed(42)\n",
    "X = np.random.randn(1000, 2)\n",
    "y = (X[:, 0] + X[:, 1] > 0).astype(int)\n",
    "\n",
    "# Split data\n",
    "X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)\n",
    "\n",
    "print(f\"Training set size: {X_train.shape}\")\n",
    "print(f\"Test set size: {X_test.shape}\")\n",
    "print(f\"Class distribution: {np.bincount(y_train)}\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Visualize data\n",
    "plt.figure(figsize=(10, 6))\n",
    "plt.scatter(X_train[y_train==0, 0], X_train[y_train==0, 1], label='Class 0', alpha=0.7)\n",
    "plt.scatter(X_train[y_train==1, 0], X_train[y_train==1, 1], label='Class 1', alpha=0.7)\n",
    "plt.xlabel('Feature 1')\n",
    "plt.ylabel('Feature 2')\n",
    "plt.title('Sample Data Visualization')\n",
    "plt.legend()\n",
    "plt.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Simple neural network\n",
    "class SimpleNN(nn.Module):\n",
    "    def __init__(self, input_size, hidden_size, output_size):\n",
    "        super(SimpleNN, self).__init__()\n",
    "        self.fc1 = nn.Linear(input_size, hidden_size)\n",
    "        self.fc2 = nn.Linear(hidden_size, output_size)\n",
    "        self.relu = nn.ReLU()\n",
    "        self.sigmoid = nn.Sigmoid()\n",
    "    \n",
    "    def forward(self, x):\n",
    "        x = self.relu(self.fc1(x))\n",
    "        x = self.sigmoid(self.fc2(x))\n",
    "        return x\n",
    "\n",
    "# Create model\n",
    "model = SimpleNN(input_size=2, hidden_size=10, output_size=1)\n",
    "model = model.to(device)\n",
    "\n",
    "print(f\"Model created: {model}\")\n",
    "print(f\"Model parameters: {sum(p.numel() for p in model.parameters())}\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Train model\n",
    "criterion = nn.BCELoss()\n",
    "optimizer = torch.optim.Adam(model.parameters(), lr=0.01)\n",
    "\n",
    "# Convert to tensors\n",
    "X_train_tensor = torch.FloatTensor(X_train).to(device)\n",
    "y_train_tensor = torch.FloatTensor(y_train).reshape(-1, 1).to(device)\n",
    "X_test_tensor = torch.FloatTensor(X_test).to(device)\n",
    "y_test_tensor = torch.FloatTensor(y_test).reshape(-1, 1).to(device)\n",
    "\n",
    "# Training loop\n",
    "epochs = 100\n",
    "losses = []\n",
    "\n",
    "for epoch in range(epochs):\n",
    "    # Forward pass\n",
    "    outputs = model(X_train_tensor)\n",
    "    loss = criterion(outputs, y_train_tensor)\n",
    "    \n",
    "    # Backward pass\n",
    "    optimizer.zero_grad()\n",
    "    loss.backward()\n",
    "    optimizer.step()\n",
    "    \n",
    "    losses.append(loss.item())\n",
    "    \n",
    "    if (epoch + 1) % 20 == 0:\n",
    "        print(f'Epoch [{epoch+1}/{epochs}], Loss: {loss.item():.4f}')\n",
    "\n",
    "print('Training completed!')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Plot training loss\n",
    "plt.figure(figsize=(10, 6))\n",
    "plt.plot(losses)\n",
    "plt.xlabel('Epoch')\n",
    "plt.ylabel('Loss')\n",
    "plt.title('Training Loss')\n",
    "plt.grid(True)\n",
    "plt.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Evaluate model\n",
    "with torch.no_grad():\n",
    "    model.eval()\n",
    "    test_outputs = model(X_test_tensor)\n",
    "    test_predictions = (test_outputs > 0.5).float()\n",
    "    accuracy = (test_predictions == y_test_tensor).float().mean()\n",
    "    \n",
    "    print(f'Test Accuracy: {accuracy.item():.4f}')\n",
    "    \n",
    "    # Confusion matrix\n",
    "    from sklearn.metrics import confusion_matrix\n",
    "    cm = confusion_matrix(y_test, test_predictions.cpu().numpy())\n",
    "    print(f'Confusion Matrix:\\n{cm}')"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Congratulations! 🎉\n",
    "\n",
    "You've successfully:\n",
    "- Set up your AI/ML environment\n",
    "- Created and trained your first neural network\n",
    "- Evaluated model performance\n",
    "\n",
    "This is just the beginning of your AI/ML journey. Keep exploring and learning!"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.9.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF

    print_success "Example notebook created"
}

# Main setup function
main() {
    echo "🎵 Vibe Coding Guide - ML Environment Setup"
    echo "=============================================="
    echo ""
    echo "This script will set up your AI/ML development environment."
    echo "Perfect for senior engineers transitioning to AI/ML."
    echo ""
    
    # Check if conda is installed
    if ! check_conda; then
        install_conda
    fi
    
    # Create ML environment
    create_ml_environment
    
    # Install packages
    install_packages
    
    # Install VS Code extensions
    install_vscode_extensions
    
    # Create project structure
    create_project_structure
    
    # Create example notebook
    create_example_notebook
    
    echo ""
    echo "🎉 Setup Complete!"
    echo "=================="
    echo ""
    echo "Your AI/ML development environment is ready!"
    echo ""
    echo "Next steps:"
    echo "1. Activate your environment: conda activate ml-dev"
    echo "2. Start Jupyter Lab: jupyter lab"
    echo "3. Open the example notebook: notebooks/01-getting-started.ipynb"
    echo "4. Begin your AI/ML journey!"
    echo ""
    echo "Happy coding! 🚀"
}

# Run main function
main "$@"