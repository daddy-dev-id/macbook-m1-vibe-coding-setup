#!/bin/bash

# MacBook M1 Performance Checker for Vibe Coding
# This script checks M1 performance and optimization status

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_header() {
    echo -e "${PURPLE}=== $1 ===${NC}"
}

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

print_metric() {
    echo -e "${CYAN}📊 $1${NC}"
}

# Check M1 hardware information
check_m1_hardware() {
    print_header "M1 Hardware Information"
    
    # CPU Information
    echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
    echo "Performance Cores: $(sysctl -n hw.perflevel0.physicalcpu)"
    echo "Efficiency Cores: $(sysctl -n hw.perflevel1.physicalcpu)"
    echo "Total Cores: $(sysctl -n hw.ncpu)"
    
    # Memory Information
    memory_gb=$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2}')
    echo "Memory: $memory_gb"
    
    # GPU Information
    echo "GPU: $(system_profiler SPDisplaysDataType | grep "Chipset Model" | head -1 | awk -F': ' '{print $2}')"
    
    # Neural Engine
    neural_engine=$(system_profiler SPHardwareDataType | grep -i "neural" | awk -F': ' '{print $2}')
    if [[ -n "$neural_engine" ]]; then
        echo "Neural Engine: $neural_engine"
    else
        echo "Neural Engine: 16-core"
    fi
    
    echo
}

# Check system performance
check_system_performance() {
    print_header "System Performance"
    
    # CPU Usage
    cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    print_metric "CPU Usage: ${cpu_usage}%"
    
    # Memory Usage
    memory_info=$(top -l 1 | grep "PhysMem")
    print_metric "Memory: $memory_info"
    
    # Load Average
    load_avg=$(uptime | awk -F'load averages:' '{print $2}')
    print_metric "Load Average:$load_avg"
    
    # Disk Usage
    disk_usage=$(df -h / | awk 'NR==2 {print $5}')
    print_metric "Disk Usage: $disk_usage"
    
    echo
}

# Check M1 GPU status
check_m1_gpu() {
    print_header "M1 GPU Status"
    
    if command -v python3 &> /dev/null; then
        python3 -c "
import torch
import sys

print(f'PyTorch version: {torch.__version__}')
print(f'M1 GPU available: {torch.backends.mps.is_available()}')
print(f'M1 GPU built: {torch.backends.mps.is_built()}')

if torch.backends.mps.is_available():
    print('✅ M1 GPU is available and ready')
    try:
        # Test M1 GPU
        device = torch.device('mps')
        x = torch.randn(100, 100, device=device)
        y = torch.randn(100, 100, device=device)
        z = torch.mm(x, y)
        print('✅ M1 GPU test passed')
        print(f'GPU Memory allocated: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB')
    except Exception as e:
        print(f'❌ M1 GPU test failed: {e}')
else:
    print('❌ M1 GPU not available')
    print('Make sure PyTorch is installed with M1 support')
"
    else
        print_error "Python3 not found. Please install Python first."
    fi
    
    echo
}

# Check TensorFlow M1 support
check_tensorflow_m1() {
    print_header "TensorFlow M1 Status"
    
    if command -v python3 &> /dev/null; then
        python3 -c "
import sys
try:
    import tensorflow as tf
    print(f'TensorFlow version: {tf.__version__}')
    
    # Check for Metal GPU
    gpus = tf.config.list_physical_devices('GPU')
    if gpus:
        print('✅ Metal GPU available')
        for gpu in gpus:
            print(f'GPU: {gpu}')
    else:
        print('❌ No Metal GPU found')
        
    # Check for Metal plugin
    try:
        import tensorflow_metal
        print('✅ TensorFlow Metal plugin installed')
    except ImportError:
        print('❌ TensorFlow Metal plugin not installed')
        
except ImportError:
    print('❌ TensorFlow not installed')
except Exception as e:
    print(f'❌ Error checking TensorFlow: {e}')
"
    else
        print_error "Python3 not found. Please install Python first."
    fi
    
    echo
}

# Check development environment
check_development_environment() {
    print_header "Development Environment"
    
    # Check Homebrew
    if command -v brew &> /dev/null; then
        print_status "Homebrew installed: $(brew --version | head -1)"
    else
        print_error "Homebrew not installed"
    fi
    
    # Check Python
    if command -v python3 &> /dev/null; then
        print_status "Python installed: $(python3 --version)"
    else
        print_error "Python3 not installed"
    fi
    
    # Check Conda
    if command -v conda &> /dev/null; then
        print_status "Conda installed: $(conda --version)"
    else
        print_error "Conda not installed"
    fi
    
    # Check Node.js
    if command -v node &> /dev/null; then
        print_status "Node.js installed: $(node --version)"
    else
        print_error "Node.js not installed"
    fi
    
    # Check Docker
    if command -v docker &> /dev/null; then
        print_status "Docker installed: $(docker --version)"
        
        # Check Docker M1 support
        if docker run --platform linux/arm64 hello-world &> /dev/null; then
            print_status "Docker M1 support verified"
        else
            print_warning "Docker M1 support test failed"
        fi
    else
        print_error "Docker not installed"
    fi
    
    # Check VS Code
    if command -v code &> /dev/null; then
        print_status "VS Code installed"
    else
        print_error "VS Code not installed"
    fi
    
    echo
}

# Check power management settings
check_power_management() {
    print_header "Power Management Settings"
    
    # Check current power settings
    echo "Current Power Settings:"
    pmset -g | grep -E "(sleep|disksleep|displaysleep|womp|networksleep)"
    
    echo
    echo "Power Management Status:"
    
    # Check AC power settings
    ac_sleep=$(pmset -g -c | grep "sleep" | awk '{print $2}')
    if [[ "$ac_sleep" == "0" ]]; then
        print_status "AC Power: Sleep disabled (good for development)"
    else
        print_warning "AC Power: Sleep enabled after ${ac_sleep} minutes"
    fi
    
    # Check battery settings
    battery_sleep=$(pmset -g -b | grep "sleep" | awk '{print $2}')
    if [[ "$battery_sleep" -gt 0 ]]; then
        print_status "Battery Power: Sleep after ${battery_sleep} minutes"
    else
        print_warning "Battery Power: Sleep disabled"
    fi
    
    # Check network sleep
    network_sleep=$(pmset -g | grep "networksleep" | awk '{print $2}')
    if [[ "$network_sleep" == "0" ]]; then
        print_status "Network: Sleep disabled (good for development)"
    else
        print_warning "Network: Sleep enabled after ${network_sleep} minutes"
    fi
    
    echo
}

# Check memory usage
check_memory_usage() {
    print_header "Memory Usage Analysis"
    
    # Get memory statistics
    vm_stat | grep -E "(Pages free|Pages active|Pages inactive|Pages speculative|Pages wired down)"
    
    echo
    echo "Memory Pressure:"
    memory_pressure | head -5
    
    echo
}

# Check temperature
check_temperature() {
    print_header "Temperature Check"
    
    if command -v powermetrics &> /dev/null; then
        echo "Current Temperature:"
        sudo powermetrics --samplers smc -n 1 | grep -i temp | head -5
    else
        print_warning "powermetrics not available for temperature check"
    fi
    
    echo
}

# Check vibe coding environment
check_vibe_coding_environment() {
    print_header "Vibe Coding Environment"
    
    # Check if vibe-coding conda environment exists
    if conda env list | grep -q "vibe-coding"; then
        print_status "Vibe Coding conda environment exists"
        
        # Check environment packages
        echo "Installed packages:"
        conda list -n vibe-coding | grep -E "(torch|tensorflow|numpy|pandas|jupyter)" | head -10
    else
        print_error "Vibe Coding conda environment not found"
    fi
    
    echo
    
    # Check if startup script exists
    if [[ -f ~/start-vibe-coding.sh ]]; then
        print_status "Vibe Coding startup script exists"
    else
        print_error "Vibe Coding startup script not found"
    fi
    
    echo
}

# Performance benchmark
run_performance_benchmark() {
    print_header "Performance Benchmark"
    
    if command -v python3 &> /dev/null; then
        python3 -c "
import time
import numpy as np
import torch
import psutil

print('Running M1 performance benchmark...')
print()

# CPU benchmark
print('CPU Benchmark:')
start = time.time()
result = sum(i*i for i in range(1000000))
cpu_time = time.time() - start
print(f'CPU computation time: {cpu_time:.4f} seconds')

# Memory benchmark
print()
print('Memory Benchmark:')
memory_before = psutil.virtual_memory().used
arr = np.random.rand(1000, 1000)
memory_after = psutil.virtual_memory().used
memory_used = (memory_after - memory_before) / 1024**2
print(f'Memory used for 1000x1000 array: {memory_used:.2f} MB')

# M1 GPU benchmark (if available)
if torch.backends.mps.is_available():
    print()
    print('M1 GPU Benchmark:')
    device = torch.device('mps')
    x = torch.randn(2000, 2000, device=device)
    y = torch.randn(2000, 2000, device=device)
    
    start = time.time()
    z = torch.mm(x, y)
    torch.mps.synchronize()  # Wait for completion
    gpu_time = time.time() - start
    print(f'M1 GPU computation time: {gpu_time:.4f} seconds')
    print(f'GPU Memory used: {torch.mps.current_allocated_memory() / 1024**2:.2f} MB')
else:
    print()
    print('M1 GPU not available for benchmark')

print()
print('Benchmark completed!')
"
    else
        print_error "Python3 not found. Cannot run benchmark."
    fi
    
    echo
}

# Main function
main() {
    echo "🍎 MacBook M1 Performance Checker for Vibe Coding"
    echo "================================================="
    echo
    
    check_m1_hardware
    check_system_performance
    check_m1_gpu
    check_tensorflow_m1
    check_development_environment
    check_power_management
    check_memory_usage
    check_temperature
    check_vibe_coding_environment
    run_performance_benchmark
    
    echo "🎉 Performance check complete!"
    echo
    echo "For optimal vibe coding performance:"
    echo "1. Keep your Mac plugged in during development"
    echo "2. Monitor memory usage with '~/m1-monitor.sh'"
    echo "3. Use M1-optimized packages when possible"
    echo "4. Restart your Mac if performance degrades"
    echo
}

# Run main function
main "$@"