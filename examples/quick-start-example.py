#!/usr/bin/env python3
"""
MacBook M1 Vibe Coding Setup - Quick Start Example

This example demonstrates the basic setup and usage of the M1-optimized
development environment for AI/ML work.

Usage:
    python examples/quick-start-example.py
"""

import os
import sys
import time
import platform
import subprocess
from pathlib import Path

# Add project root to path
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

class VibeCodingSetup:
    """Main class for vibe coding setup and demonstration."""
    
    def __init__(self):
        self.project_root = project_root
        self.system_info = self._get_system_info()
        
    def _get_system_info(self):
        """Get system information for M1 optimization."""
        return {
            'platform': platform.platform(),
            'machine': platform.machine(),
            'processor': platform.processor(),
            'python_version': platform.python_version(),
            'architecture': platform.architecture()[0]
        }
    
    def check_m1_optimization(self):
        """Check if M1 optimization is properly configured."""
        print("🍎 Checking M1 Optimization Status...")
        
        # Check if running on Apple Silicon
        if self.system_info['machine'] == 'arm64':
            print("✅ Running on Apple Silicon (M1/M2)")
        else:
            print("⚠️  Not running on Apple Silicon")
            
        # Check conda environment
        conda_env = os.environ.get('CONDA_DEFAULT_ENV')
        if conda_env:
            print(f"✅ Conda environment: {conda_env}")
        else:
            print("⚠️  No conda environment detected")
            
        # Check external storage
        llm_disk_path = "/Volumes/LLM"
        if os.path.exists(llm_disk_path):
            print(f"✅ LLM disk available: {llm_disk_path}")
        else:
            print("⚠️  LLM disk not found")
            
        return True
    
    def demonstrate_ml_setup(self):
        """Demonstrate ML framework setup and usage."""
        print("\n🤖 Demonstrating ML Setup...")
        
        try:
            import torch
            print(f"✅ PyTorch version: {torch.__version__}")
            
            # Check M1 GPU support
            if torch.backends.mps.is_available():
                print("✅ M1 GPU (Metal Performance Shaders) available")
                device = torch.device("mps")
            else:
                print("⚠️  M1 GPU not available, using CPU")
                device = torch.device("cpu")
                
        except ImportError:
            print("❌ PyTorch not installed")
            return False
            
        try:
            import tensorflow as tf
            print(f"✅ TensorFlow version: {tf.__version__}")
            
            # Check Metal GPU support
            if tf.config.list_physical_devices('GPU'):
                print("✅ TensorFlow GPU support available")
            else:
                print("⚠️  TensorFlow GPU support not available")
                
        except ImportError:
            print("❌ TensorFlow not installed")
            
        return True
    
    def run_performance_test(self):
        """Run a simple performance test."""
        print("\n⚡ Running Performance Test...")
        
        try:
            import numpy as np
            import time
            
            # Create large array
            size = 10000
            start_time = time.time()
            
            # Matrix multiplication test
            a = np.random.rand(size, size).astype(np.float32)
            b = np.random.rand(size, size).astype(np.float32)
            c = np.dot(a, b)
            
            end_time = time.time()
            duration = end_time - start_time
            
            print(f"✅ Matrix multiplication ({size}x{size}): {duration:.2f} seconds")
            
            # Memory usage
            memory_usage = c.nbytes / (1024**2)  # MB
            print(f"✅ Memory usage: {memory_usage:.2f} MB")
            
            return True
            
        except ImportError:
            print("❌ NumPy not installed")
            return False
    
    def demonstrate_task_management(self):
        """Demonstrate task management integration."""
        print("\n📋 Demonstrating Task Management...")
        
        # Check if task-master is available
        task_master_script = self.project_root / "scripts" / "task-master.sh"
        if task_master_script.exists():
            print("✅ Task Master script available")
            
            # Try to run task list command
            try:
                result = subprocess.run(
                    [str(task_master_script), "list"],
                    capture_output=True,
                    text=True,
                    timeout=10
                )
                if result.returncode == 0:
                    print("✅ Task Master working correctly")
                else:
                    print("⚠️  Task Master script has issues")
            except subprocess.TimeoutExpired:
                print("⚠️  Task Master script timed out")
            except Exception as e:
                print(f"⚠️  Task Master error: {e}")
        else:
            print("❌ Task Master script not found")
    
    def show_environment_status(self):
        """Show current environment status."""
        print("\n🔧 Environment Status:")
        
        # Python environment
        print(f"Python: {sys.executable}")
        print(f"Version: {sys.version}")
        
        # Environment variables
        important_vars = [
            'CONDA_DEFAULT_ENV',
            'CONDA_PREFIX',
            'PATH',
            'PYTHONPATH'
        ]
        
        for var in important_vars:
            value = os.environ.get(var, 'Not set')
            if var == 'PATH':
                value = f"{len(value.split(':'))} paths"
            print(f"{var}: {value}")
    
    def run_full_demo(self):
        """Run the complete demonstration."""
        print("🎵 MacBook M1 Vibe Coding Setup - Quick Start Demo")
        print("=" * 60)
        
        # System check
        self.check_m1_optimization()
        
        # ML setup demo
        self.demonstrate_ml_setup()
        
        # Performance test
        self.run_performance_test()
        
        # Task management demo
        self.demonstrate_task_management()
        
        # Environment status
        self.show_environment_status()
        
        print("\n🎯 Demo Complete!")
        print("Next steps:")
        print("1. Run: ./scripts/optimize-macbook-m1.sh")
        print("2. Run: ./scripts/setup-ml-environment.sh")
        print("3. Start vibe coding: ./scripts/task-master.sh daily")

def main():
    """Main function to run the demo."""
    setup = VibeCodingSetup()
    setup.run_full_demo()

if __name__ == "__main__":
    main()