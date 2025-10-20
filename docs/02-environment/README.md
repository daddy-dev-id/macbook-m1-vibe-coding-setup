# 02 - Development Environment

**Optimal setup for AI/ML development with your existing workflow**

---

## 🎯 **Overview**

This section covers setting up an optimal development environment for AI/ML work that integrates seamlessly with your existing development practices. We'll build on your current setup rather than replacing it.

---

## 🚀 **Quick Setup**

### **Essential Tools (30 minutes)**
```bash
# 1. Python environment
conda create -n ml-dev python=3.11
conda activate ml-dev

# 2. Essential libraries
pip install jupyter pandas numpy matplotlib seaborn scikit-learn

# 3. Deep learning framework
pip install torch torchvision torchaudio

# 4. VS Code with AI/ML extensions
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
```

### **Complete Setup (2 hours)**
```bash
# Run the complete setup script
./scripts/setup-ml-environment.sh
```

---

## 🛠️ **Core Development Environment**

### **1. Python Environment Management**

#### **Why Not Just pip?**
- **Dependency conflicts**: Different projects need different versions
- **Environment isolation**: Keep projects separate
- **Reproducibility**: Same environment across machines
- **Version control**: Track exact package versions

#### **Recommended: Conda + Poetry**
```bash
# Conda for system-level packages
conda create -n ml-dev python=3.11
conda activate ml-dev

# Poetry for project-level dependencies
poetry init
poetry add torch pandas numpy matplotlib
```

#### **Alternative: pyenv + pipenv**
```bash
# pyenv for Python version management
pyenv install 3.11.0
pyenv local 3.11.0

# pipenv for dependency management
pipenv install torch pandas numpy matplotlib
```

### **2. Code Editor: VS Code with AI Extensions**

#### **Essential Extensions**
```json
{
  "recommendations": [
    "ms-python.python",
    "ms-toolsai.jupyter",
    "ms-python.pylint",
    "ms-python.black-formatter",
    "ms-python.isort",
    "ms-toolsai.vscode-ai",
    "github.copilot",
    "ms-vscode.vscode-json"
  ]
}
```

#### **VS Code Settings for AI/ML**
```json
{
  "python.defaultInterpreterPath": "~/miniconda3/envs/ml-dev/bin/python",
  "jupyter.askForKernelRestart": false,
  "jupyter.autoStartDefaultKernel": true,
  "python.terminal.activateEnvironment": true,
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "python.formatting.provider": "black",
  "editor.formatOnSave": true
}
```

### **3. Jupyter Notebooks for Experimentation**

#### **Why Jupyter for AI/ML?**
- **Interactive development**: Test ideas quickly
- **Visualization**: See data and results immediately
- **Documentation**: Combine code, text, and visualizations
- **Experimentation**: Try different approaches easily

#### **Jupyter Setup**
```bash
# Install Jupyter
pip install jupyter jupyterlab

# Install useful extensions
pip install jupyter-contrib-nbextensions
jupyter contrib nbextension install --user

# Start JupyterLab
jupyter lab
```

#### **Jupyter Best Practices**
- **Use notebooks for exploration**: Not for production code
- **Keep notebooks clean**: Clear outputs before committing
- **Convert to scripts**: Move production code to .py files
- **Use version control**: Track notebook changes

---

## 🐳 **Containerized Development**

### **Why Docker for AI/ML?**
- **Reproducibility**: Same environment everywhere
- **Dependency management**: Isolate complex dependencies
- **GPU support**: Easy CUDA setup
- **Deployment**: Easy to move to production

### **Docker Setup for AI/ML**

#### **Dockerfile Example**
```dockerfile
FROM pytorch/pytorch:latest

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    vim \
    htop \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install Jupyter
RUN pip install jupyter jupyterlab

# Expose Jupyter port
EXPOSE 8888

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
```

#### **Docker Compose for Development**
```yaml
version: '3.8'
services:
  ml-dev:
    build: .
    ports:
      - "8888:8888"
      - "6006:6006"  # TensorBoard
    volumes:
      - .:/workspace
      - ./data:/workspace/data
      - ./models:/workspace/models
    environment:
      - JUPYTER_ENABLE_LAB=yes
    command: jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```

---

## 🎯 **AI/ML Specific Tools**

### **1. Data Science Libraries**

#### **Essential Libraries**
```python
# Data manipulation
import pandas as pd
import numpy as np

# Visualization
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px

# Machine learning
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, classification_report
from sklearn.preprocessing import StandardScaler

# Deep learning
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset

# Jupyter widgets
import ipywidgets as widgets
from IPython.display import display
```

#### **Installation**
```bash
# Core data science stack
pip install pandas numpy matplotlib seaborn plotly

# Machine learning
pip install scikit-learn xgboost lightgbm

# Deep learning
pip install torch torchvision torchaudio
# or
pip install tensorflow tensorboard

# Jupyter extensions
pip install ipywidgets jupyter-dash
```

### **2. Experiment Tracking**

#### **Why Track Experiments?**
- **Reproducibility**: Know exactly what you did
- **Comparison**: Compare different approaches
- **Debugging**: Understand what went wrong
- **Collaboration**: Share results with team

#### **Recommended: Weights & Biases**
```python
import wandb

# Initialize experiment
wandb.init(project="my-ml-project", name="experiment-1")

# Log metrics
wandb.log({"accuracy": 0.95, "loss": 0.05})

# Log model
wandb.log_model(model, "my-model")
```

#### **Alternative: MLflow**
```python
import mlflow
import mlflow.sklearn

# Start experiment
with mlflow.start_run():
    # Train model
    model = train_model()
    
    # Log metrics
    mlflow.log_metric("accuracy", accuracy)
    
    # Log model
    mlflow.sklearn.log_model(model, "model")
```

### **3. Model Visualization**

#### **TensorBoard for PyTorch**
```python
from torch.utils.tensorboard import SummaryWriter

# Create writer
writer = SummaryWriter('runs/experiment_1')

# Log metrics
writer.add_scalar('Loss/Train', train_loss, epoch)
writer.add_scalar('Accuracy/Train', train_acc, epoch)

# Log model graph
writer.add_graph(model, input_to_model)

# Close writer
writer.close()
```

#### **Weights & Biases for All Frameworks**
```python
import wandb

# Log metrics
wandb.log({"train_loss": loss, "epoch": epoch})

# Log images
wandb.log({"predictions": wandb.Image(predictions)})

# Log histograms
wandb.log({"weights": wandb.Histogram(model.parameters())})
```

---

## 🔧 **Development Workflow Integration**

### **1. Git Workflow for AI/ML**

#### **Traditional Git Workflow**
```
feature-branch → main
```

#### **AI/ML Git Workflow**
```
experiment-branch → model-branch → main
```

#### **Recommended Branching Strategy**
```
main
├── experiments/
│   ├── experiment-1
│   ├── experiment-2
│   └── experiment-3
├── models/
│   ├── model-v1
│   ├── model-v2
│   └── model-v3
└── production/
    └── production-model
```

#### **Git LFS for Large Files**
```bash
# Install Git LFS
git lfs install

# Track large files
git lfs track "*.pkl"
git lfs track "*.h5"
git lfs track "*.bin"

# Add .gitattributes
echo "*.pkl filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
```

### **2. Project Structure**

#### **Recommended AI/ML Project Structure**
```
my-ml-project/
├── data/
│   ├── raw/           # Original data
│   ├── processed/     # Cleaned data
│   └── external/      # External data sources
├── notebooks/         # Jupyter notebooks
├── src/              # Source code
│   ├── data/         # Data processing
│   ├── models/       # Model definitions
│   ├── training/     # Training scripts
│   └── evaluation/   # Evaluation scripts
├── models/           # Trained models
├── experiments/      # Experiment configs
├── tests/           # Unit tests
├── docs/            # Documentation
├── requirements.txt # Dependencies
├── environment.yml  # Conda environment
└── README.md        # Project description
```

### **3. Configuration Management**

#### **Using Hydra for Configuration**
```python
# config.yaml
defaults:
  - model: resnet50
  - data: cifar10
  - training: adam

model:
  resnet50:
    num_classes: 10
    pretrained: true

data:
  cifar10:
    batch_size: 32
    num_workers: 4

training:
  adam:
    lr: 0.001
    weight_decay: 0.0001
```

#### **Using Python Config Files**
```python
# config.py
import os

class Config:
    # Data
    DATA_PATH = os.getenv('DATA_PATH', './data')
    BATCH_SIZE = int(os.getenv('BATCH_SIZE', 32))
    
    # Model
    MODEL_NAME = os.getenv('MODEL_NAME', 'resnet50')
    NUM_CLASSES = int(os.getenv('NUM_CLASSES', 10))
    
    # Training
    LEARNING_RATE = float(os.getenv('LEARNING_RATE', 0.001))
    EPOCHS = int(os.getenv('EPOCHS', 100))
```

---

## 🚀 **Performance Optimization**

### **1. GPU Setup**

#### **CUDA Installation**
```bash
# Check GPU availability
nvidia-smi

# Install CUDA toolkit
conda install cudatoolkit=11.8 -c nvidia

# Install PyTorch with CUDA
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

#### **GPU Memory Management**
```python
import torch

# Check GPU availability
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print(f"Using device: {device}")

# Monitor GPU memory
print(f"GPU memory allocated: {torch.cuda.memory_allocated()/1024**3:.2f} GB")
print(f"GPU memory cached: {torch.cuda.memory_reserved()/1024**3:.2f} GB")

# Clear GPU memory
torch.cuda.empty_cache()
```

### **2. Data Loading Optimization**

#### **Efficient Data Loading**
```python
from torch.utils.data import DataLoader, Dataset
import torchvision.transforms as transforms

# Custom dataset
class MyDataset(Dataset):
    def __init__(self, data, transform=None):
        self.data = data
        self.transform = transform
    
    def __len__(self):
        return len(self.data)
    
    def __getitem__(self, idx):
        sample = self.data[idx]
        if self.transform:
            sample = self.transform(sample)
        return sample

# DataLoader with optimization
dataloader = DataLoader(
    dataset,
    batch_size=32,
    shuffle=True,
    num_workers=4,  # Parallel data loading
    pin_memory=True,  # Faster GPU transfer
    persistent_workers=True  # Keep workers alive
)
```

### **3. Model Optimization**

#### **Mixed Precision Training**
```python
from torch.cuda.amp import autocast, GradScaler

# Enable mixed precision
scaler = GradScaler()

for epoch in range(epochs):
    for batch in dataloader:
        optimizer.zero_grad()
        
        # Forward pass with autocast
        with autocast():
            outputs = model(batch['input'])
            loss = criterion(outputs, batch['target'])
        
        # Backward pass with scaler
        scaler.scale(loss).backward()
        scaler.step(optimizer)
        scaler.update()
```

---

## 📋 **Environment Checklist**

### **Essential Setup**
- [ ] Python 3.11+ installed
- [ ] Conda or pyenv for environment management
- [ ] VS Code with AI/ML extensions
- [ ] Jupyter Lab installed
- [ ] Git LFS for large files
- [ ] Docker for containerization (optional)

### **AI/ML Libraries**
- [ ] pandas, numpy, matplotlib, seaborn
- [ ] scikit-learn for traditional ML
- [ ] PyTorch or TensorFlow for deep learning
- [ ] Jupyter widgets for interactive development

### **Development Tools**
- [ ] Experiment tracking (Weights & Biases or MLflow)
- [ ] Model visualization (TensorBoard)
- [ ] Configuration management (Hydra or config files)
- [ ] Testing framework (pytest)

### **Performance Optimization**
- [ ] GPU setup (if available)
- [ ] Efficient data loading
- [ ] Mixed precision training
- [ ] Memory monitoring

---

## 🎯 **Next Steps**

### **Immediate Actions**
1. **Set up Python environment** with essential libraries
2. **Install VS Code** with AI/ML extensions
3. **Create your first Jupyter notebook**
4. **Set up experiment tracking**

### **This Week**
- [ ] Complete environment setup
- [ ] Run your first ML experiment
- [ ] Set up project structure
- [ ] Configure Git LFS

### **This Month**
- [ ] Set up containerized development
- [ ] Implement experiment tracking
- [ ] Optimize for performance
- [ ] Create reusable templates

---

**Your development environment is the foundation of your AI/ML journey. Take time to set it up properly - it will pay dividends throughout your learning process.** 🚀

---

**Next:** [03 - Workflow Patterns](03-workflow/README.md)