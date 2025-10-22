#!/bin/bash

# Fresh MacBook Air Performance Benchmark
# This script runs basic performance tests without requiring Xcode tools

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
    echo "Memory: $memory_gb GB"
    
    # GPU Information
    echo "GPU: $(system_profiler SPDisplaysDataType | grep "Chipset Model" | head -1 | awk -F': ' '{print $2}')"
    
    # Neural Engine
    echo "Neural Engine: 16-core"
    
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
        print_status "Python installed: $(python3 --version 2>/dev/null || echo 'Version check failed')"
    else
        print_error "Python3 not installed"
    fi
    
    # Check Node.js
    if command -v node &> /dev/null; then
        print_status "Node.js installed: $(node --version)"
    else
        print_warning "Node.js not installed"
    fi
    
    # Check Git
    if command -v git &> /dev/null; then
        print_status "Git installed: $(git --version)"
    else
        print_error "Git not installed"
    fi
    
    # Check VS Code
    if command -v code &> /dev/null; then
        print_status "VS Code installed"
    else
        print_warning "VS Code not installed"
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

# Simple performance benchmark
run_simple_benchmark() {
    print_header "Simple Performance Benchmark"
    
    # CPU benchmark using built-in tools
    print_info "Running CPU benchmark..."
    start_time=$(date +%s.%N)
    
    # Simple CPU-intensive task
    for i in {1..1000000}; do
        echo $i > /dev/null
    done
    
    end_time=$(date +%s.%N)
    duration=$(echo "$end_time - $start_time" | bc -l)
    print_metric "CPU computation time: ${duration} seconds"
    
    # Memory benchmark
    print_info "Running memory benchmark..."
    start_time=$(date +%s.%N)
    
    # Create a large array in memory
    large_array=()
    for i in {1..100000}; do
        large_array+=($i)
    done
    
    end_time=$(date +%s.%N)
    duration=$(echo "$end_time - $start_time" | bc -l)
    print_metric "Memory allocation time: ${duration} seconds"
    
    # Disk I/O benchmark
    print_info "Running disk I/O benchmark..."
    start_time=$(date +%s.%N)
    
    # Create and write a test file
    dd if=/dev/zero of=/tmp/benchmark_test bs=1M count=100 2>/dev/null
    
    end_time=$(date +%s.%N)
    duration=$(echo "$end_time - $start_time" | bc -l)
    print_metric "Disk write time (100MB): ${duration} seconds"
    
    # Clean up
    rm -f /tmp/benchmark_test
    
    echo
}

# Check system temperature (if possible)
check_temperature() {
    print_header "Temperature Check"
    
    if command -v powermetrics &> /dev/null; then
        echo "Current Temperature:"
        sudo powermetrics --samplers smc -n 1 | grep -i temp | head -5
    else
        print_warning "powermetrics not available for temperature check"
        print_info "Install Xcode command line tools to enable temperature monitoring"
    fi
    
    echo
}

# Main function
main() {
    echo "🍎 Fresh MacBook Air Performance Benchmark"
    echo "=========================================="
    echo
    print_info "This is a baseline performance check for your fresh MacBook Air"
    echo
    
    check_m1_hardware
    check_system_performance
    check_development_environment
    check_power_management
    check_memory_usage
    check_temperature
    run_simple_benchmark
    
    echo "🎉 Performance benchmark complete!"
    echo
    echo "Next steps for M1 optimization:"
    echo "1. Install Xcode command line tools: xcode-select --install"
    echo "2. Run: ./scripts/optimize-macbook-m1.sh"
    echo "3. Set up development environment"
    echo "4. Run full performance check: ./monitoring/check-m1-performance.sh"
    echo
}

# Run main function
main "$@"