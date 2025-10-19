# 04 - MacBook M1 Optimization for Vibe Coding

**Complete MacBook M1 optimization guide for AI/ML development and vibe coding**

---

## 🎯 **Overview**

This guide provides comprehensive MacBook M1 optimization specifically tailored for vibe coding and AI/ML development. It covers Apple Silicon-specific optimizations, performance tuning, and development environment setup.

---

## 🚀 **Quick Setup (5 minutes)**

### **Immediate M1 Optimization**
```bash
# Navigate to scripts
cd scripts/

# Run M1 optimization script
./optimize-macbook-m1.sh

# Verify M1 optimizations
./check-m1-performance.sh
```

### **Vibe Coding Environment Setup**
```bash
# Set up vibe coding environment
./setup-vibe-coding-m1.sh

# Start optimized development
./start-vibe-coding.sh
```

---

## 🍎 **Apple Silicon Specific Optimizations**

### **1. M1 Architecture Understanding**

#### **M1 Chip Architecture**
- **CPU**: 8-core (4 performance + 4 efficiency cores)
- **GPU**: 7-8 core integrated GPU
- **Neural Engine**: 16-core for ML acceleration
- **Unified Memory**: Up to 16GB shared between CPU/GPU
- **Memory Bandwidth**: 68.25 GB/s

#### **Why M1 is Perfect for Vibe Coding**
- **Unified Memory**: No data copying between CPU/GPU
- **Neural Engine**: Hardware acceleration for ML workloads
- **Power Efficiency**: Long battery life for coding sessions
- **Silent Operation**: No fan noise during development

### **2. M1-Specific Performance Tuning**

#### **CPU Performance Optimization**
```bash
# Check M1 CPU cores
sysctl -n machdep.cpu.brand_string
sysctl -n hw.ncpu
sysctl -n hw.perflevel0.physicalcpu
sysctl -n hw.perflevel1.physicalcpu

# Optimize for performance cores
sudo pmset -a powernap 0
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
```

#### **Memory Optimization for M1**
```bash
# Check unified memory usage
vm_stat | grep -E "(Pages free|Pages active|Pages inactive|Pages speculative)"

# Optimize memory pressure
sudo purge
```

#### **GPU and Neural Engine Optimization**
```bash
# Check GPU cores
system_profiler SPDisplaysDataType | grep -A 5 "Chipset Model"

# Check Neural Engine
system_profiler SPHardwareDataType | grep -i "neural"
```

### **3. M1-Specific Development Tools**

#### **Homebrew for Apple Silicon**
```bash
# Install Homebrew for Apple Silicon
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc

# Install M1-optimized packages
brew install --cask miniconda
brew install python@3.11
brew install node@18
```

#### **Python for M1**
```bash
# Install Python with M1 optimizations
conda create -n vibe-coding python=3.11
conda activate vibe-coding

# Install M1-optimized packages
pip install --upgrade pip
pip install numpy scipy pandas matplotlib seaborn
pip install torch torchvision torchaudio  # M1 optimized
pip install tensorflow-macos tensorflow-metal  # M1 optimized
```

---

## 🧠 **Vibe Coding Environment Setup**

### **1. Core Vibe Coding Tools**

#### **Essential M1-Optimized Tools**
```bash
# Install core development tools
brew install --cask visual-studio-code
brew install --cask cursor
brew install --cask iterm2
brew install --cask docker

# Install AI/ML specific tools
brew install --cask jupyterlab
brew install --cask anaconda
```

#### **VS Code Extensions for M1**
```json
{
  "recommendations": [
    "ms-python.python",
    "ms-toolsai.jupyter",
    "ms-python.pylint",
    "ms-python.black-formatter",
    "github.copilot",
    "ms-vscode.vscode-json",
    "ms-python.isort",
    "ms-toolsai.vscode-ai"
  ]
}
```

### **2. M1-Optimized Python Environment**

#### **Conda Environment Setup**
```bash
# Create M1-optimized environment
conda create -n vibe-coding python=3.11
conda activate vibe-coding

# Install M1-optimized packages
conda install -c conda-forge numpy scipy pandas matplotlib seaborn
conda install -c conda-forge jupyter jupyterlab
conda install -c conda-forge scikit-learn

# Install PyTorch for M1
conda install pytorch torchvision torchaudio -c pytorch

# Install TensorFlow for M1
conda install tensorflow-macos tensorflow-metal -c apple
```

#### **Performance Verification**
```python
# Test M1 performance
import torch
import numpy as np
import time

# Check M1 GPU availability
print(f"PyTorch MPS available: {torch.backends.mps.is_available()}")
print(f"PyTorch MPS built: {torch.backends.mps.is_built()}")

# Test M1 Neural Engine
device = torch.device("mps" if torch.backends.mps.is_available() else "cpu")
print(f"Using device: {device}")

# Performance test
x = torch.randn(1000, 1000, device=device)
start = time.time()
y = torch.mm(x, x)
end = time.time()
print(f"M1 GPU computation time: {end - start:.4f} seconds")
```

### **3. Docker for M1**

#### **Docker Desktop M1 Setup**
```bash
# Install Docker Desktop for M1
brew install --cask docker

# Start Docker Desktop
open -a Docker

# Verify M1 support
docker run --platform linux/arm64 hello-world
```

#### **M1-Optimized Dockerfile**
```dockerfile
# Use M1-optimized base image
FROM --platform=linux/arm64 python:3.11-slim

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
RUN pip install --no-cache-dir -r requirements.txt

# Install Jupyter
RUN pip install jupyter jupyterlab

# Expose port
EXPOSE 8888

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
```

---

## ⚡ **Performance Optimization**

### **1. M1 Memory Management**

#### **Unified Memory Optimization**
```bash
# Check memory usage
vm_stat | grep -E "(Pages free|Pages active|Pages inactive|Pages speculative)"

# Monitor memory pressure
sudo purge

# Check memory pressure
memory_pressure
```

#### **Python Memory Optimization**
```python
# M1 memory optimization
import gc
import psutil
import torch

# Monitor memory usage
def check_memory():
    process = psutil.Process()
    memory_info = process.memory_info()
    print(f"RSS: {memory_info.rss / 1024**2:.2f} MB")
    print(f"VMS: {memory_info.vms / 1024**2:.2f} MB")
    
    if torch.backends.mps.is_available():
        print(f"GPU Memory: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB")

# Force garbage collection
gc.collect()
torch.mps.empty_cache()
```

### **2. M1 GPU Acceleration**

#### **PyTorch M1 GPU Setup**
```python
import torch

# Check M1 GPU availability
if torch.backends.mps.is_available():
    device = torch.device("mps")
    print("M1 GPU available!")
else:
    device = torch.device("cpu")
    print("Using CPU")

# Test M1 GPU performance
def test_m1_gpu():
    # Create large tensors
    x = torch.randn(5000, 5000, device=device)
    y = torch.randn(5000, 5000, device=device)
    
    # Time matrix multiplication
    import time
    start = time.time()
    z = torch.mm(x, y)
    end = time.time()
    
    print(f"M1 GPU computation time: {end - start:.4f} seconds")
    return z

# Run test
result = test_m1_gpu()
```

#### **TensorFlow M1 GPU Setup**
```python
import tensorflow as tf

# Check M1 GPU availability
print(f"TensorFlow version: {tf.__version__}")
print(f"Metal GPU available: {tf.config.list_physical_devices('GPU')}")

# Configure for M1
tf.config.experimental.set_memory_growth(tf.config.list_physical_devices('GPU')[0], True)

# Test M1 GPU performance
def test_m1_tensorflow():
    # Create large tensors
    x = tf.random.normal([5000, 5000])
    y = tf.random.normal([5000, 5000])
    
    # Time matrix multiplication
    import time
    start = time.time()
    z = tf.matmul(x, y)
    end = time.time()
    
    print(f"M1 GPU computation time: {end - start:.4f} seconds")
    return z

# Run test
result = test_m1_tensorflow()
```

### **3. M1 Neural Engine Optimization**

#### **Core ML Integration**
```python
import coremltools as ct
import torch

# Convert PyTorch model to Core ML
def convert_to_coreml(model, input_shape):
    # Set model to evaluation mode
    model.eval()
    
    # Create dummy input
    dummy_input = torch.randn(1, *input_shape)
    
    # Trace the model
    traced_model = torch.jit.trace(model, dummy_input)
    
    # Convert to Core ML
    coreml_model = ct.convert(
        traced_model,
        inputs=[ct.TensorType(shape=dummy_input.shape)],
        outputs=[ct.TensorType()],
        compute_units=ct.ComputeUnit.ALL  # Use Neural Engine
    )
    
    return coreml_model

# Example usage
# model = YourPyTorchModel()
# coreml_model = convert_to_coreml(model, (3, 224, 224))
```

---

## 🔧 **Development Environment Optimization**

### **1. Terminal and Shell Optimization**

#### **iTerm2 M1 Configuration**
```bash
# Install iTerm2
brew install --cask iterm2

# Configure iTerm2 for M1
# - Use native M1 binary
# - Enable GPU acceleration
# - Optimize for performance
```

#### **Zsh Configuration for M1**
```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install M1-optimized plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Configure .zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc
```

### **2. VS Code M1 Optimization**

#### **VS Code Settings for M1**
```json
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
  "terminal.integrated.gpuAcceleration": "on"
}
```

### **3. Jupyter Lab M1 Optimization**

#### **Jupyter Lab Configuration**
```python
# jupyter_lab_config.py
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.allow_root = True
c.ServerApp.token = ''
c.ServerApp.password = ''

# M1 optimizations
c.ServerApp.allow_origin = '*'
c.ServerApp.disable_check_xsrf = True
c.ServerApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy': "frame-ancestors 'self' *;"
    }
}
```

---

## 📊 **Monitoring and Diagnostics**

### **1. M1 Performance Monitoring**

#### **System Monitoring Script**
```bash
#!/bin/bash
# m1-monitor.sh

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
```

#### **Python Performance Monitor**
```python
# m1_performance_monitor.py
import psutil
import torch
import time
import matplotlib.pyplot as plt

class M1PerformanceMonitor:
    def __init__(self):
        self.cpu_usage = []
        self.memory_usage = []
        self.timestamps = []
    
    def collect_metrics(self):
        """Collect current performance metrics"""
        cpu_percent = psutil.cpu_percent(interval=1)
        memory_percent = psutil.virtual_memory().percent
        
        self.cpu_usage.append(cpu_percent)
        self.memory_usage.append(memory_percent)
        self.timestamps.append(time.time())
        
        return {
            'cpu': cpu_percent,
            'memory': memory_percent,
            'timestamp': time.time()
        }
    
    def plot_metrics(self):
        """Plot performance metrics"""
        plt.figure(figsize=(12, 6))
        
        plt.subplot(1, 2, 1)
        plt.plot(self.timestamps, self.cpu_usage)
        plt.title('CPU Usage Over Time')
        plt.ylabel('CPU %')
        plt.xlabel('Time')
        
        plt.subplot(1, 2, 2)
        plt.plot(self.timestamps, self.memory_usage)
        plt.title('Memory Usage Over Time')
        plt.ylabel('Memory %')
        plt.xlabel('Time')
        
        plt.tight_layout()
        plt.show()
    
    def check_m1_gpu(self):
        """Check M1 GPU status"""
        if torch.backends.mps.is_available():
            print("M1 GPU: Available")
            print(f"GPU Memory: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB")
        else:
            print("M1 GPU: Not available")

# Usage
monitor = M1PerformanceMonitor()
metrics = monitor.collect_metrics()
print(f"CPU: {metrics['cpu']}%, Memory: {metrics['memory']}%")
monitor.check_m1_gpu()
```

### **2. Vibe Coding Performance Metrics**

#### **Development Environment Metrics**
```python
# vibe_coding_metrics.py
import time
import psutil
import torch
import numpy as np

class VibeCodingMetrics:
    def __init__(self):
        self.start_time = time.time()
        self.code_compilation_times = []
        self.model_training_times = []
        self.memory_usage = []
    
    def measure_compilation_time(self, func):
        """Measure code compilation time"""
        start = time.time()
        result = func()
        end = time.time()
        
        self.code_compilation_times.append(end - start)
        return result
    
    def measure_training_time(self, model, data):
        """Measure model training time"""
        start = time.time()
        # Training code here
        end = time.time()
        
        self.model_training_times.append(end - start)
    
    def get_performance_summary(self):
        """Get performance summary"""
        total_time = time.time() - self.start_time
        
        return {
            'total_time': total_time,
            'avg_compilation_time': np.mean(self.code_compilation_times),
            'avg_training_time': np.mean(self.model_training_times),
            'memory_usage': psutil.virtual_memory().percent,
            'cpu_usage': psutil.cpu_percent()
        }

# Usage
metrics = VibeCodingMetrics()
summary = metrics.get_performance_summary()
print(f"Performance Summary: {summary}")
```

---

## 🎯 **Vibe Coding Best Practices for M1**

### **1. M1-Specific Development Patterns**

#### **Memory-Efficient Coding**
```python
# Use M1 unified memory efficiently
import torch
import gc

def memory_efficient_training():
    # Clear cache before training
    torch.mps.empty_cache()
    gc.collect()
    
    # Use smaller batch sizes if needed
    batch_size = 32  # Adjust based on available memory
    
    # Monitor memory usage
    if torch.backends.mps.is_available():
        print(f"GPU Memory: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB")
    
    # Training code here
    pass
```

#### **M1-Optimized Data Loading**
```python
# Optimize data loading for M1
from torch.utils.data import DataLoader, Dataset
import torch

class M1OptimizedDataset(Dataset):
    def __init__(self, data):
        self.data = data
    
    def __len__(self):
        return len(self.data)
    
    def __getitem__(self, idx):
        return self.data[idx]

# M1-optimized DataLoader
dataloader = DataLoader(
    dataset,
    batch_size=32,
    shuffle=True,
    num_workers=2,  # M1 works well with 2 workers
    pin_memory=False,  # Not needed for M1 unified memory
    persistent_workers=True
)
```

### **2. M1-Specific Debugging**

#### **M1 Debugging Tools**
```python
# M1 debugging utilities
import torch
import psutil
import time

def debug_m1_performance():
    """Debug M1 performance issues"""
    
    # Check M1 GPU availability
    print(f"M1 GPU available: {torch.backends.mps.is_available()}")
    print(f"M1 GPU built: {torch.backends.mps.is_built()}")
    
    # Check memory usage
    memory = psutil.virtual_memory()
    print(f"Memory usage: {memory.percent}%")
    print(f"Available memory: {memory.available / 1024**3:.2f} GB")
    
    # Check CPU usage
    cpu_percent = psutil.cpu_percent(interval=1)
    print(f"CPU usage: {cpu_percent}%")
    
    # Check M1 GPU memory
    if torch.backends.mps.is_available():
        print(f"GPU memory allocated: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB")
        print(f"GPU memory cached: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB")

# Run debugging
debug_m1_performance()
```

---

## 🚀 **Quick Start Checklist**

### **Essential M1 Setup**
- [ ] Install Homebrew for Apple Silicon
- [ ] Install Python with M1 optimizations
- [ ] Install PyTorch for M1
- [ ] Install TensorFlow for M1
- [ ] Install VS Code with M1 extensions
- [ ] Install Docker Desktop for M1
- [ ] Install Jupyter Lab

### **Performance Optimization**
- [ ] Configure M1 power management
- [ ] Optimize unified memory usage
- [ ] Enable M1 GPU acceleration
- [ ] Set up M1 Neural Engine
- [ ] Configure development tools for M1

### **Vibe Coding Environment**
- [ ] Set up M1-optimized Python environment
- [ ] Configure VS Code for M1
- [ ] Set up Jupyter Lab for M1
- [ ] Install M1-optimized packages
- [ ] Test M1 performance

---

## 📚 **Additional Resources**

### **M1-Specific Documentation**
- [Apple Silicon Performance Guide](https://developer.apple.com/documentation/apple-silicon)
- [PyTorch M1 Support](https://pytorch.org/get-started/locally/)
- [TensorFlow M1 Support](https://developer.apple.com/metal/tensorflow-plugin/)
- [Core ML Documentation](https://developer.apple.com/documentation/coreml)

### **Vibe Coding Resources**
- [Vibe Coding Philosophy](01-mindset/README.md)
- [Development Environment Setup](02-environment/README.md)
- [Workflow Patterns](03-workflow/README.md)

---

**Your MacBook M1 is perfectly suited for vibe coding with its unified memory architecture, Neural Engine, and power efficiency. These optimizations will help you get the most out of your M1 for AI/ML development!** 🚀

---

**Next:** [05 - Advanced M1 Optimization](05-advanced-m1-optimization/README.md)