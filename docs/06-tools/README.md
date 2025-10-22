# 06 - Productivity Tools

**Essential tools and techniques for efficient AI/ML development**

---

## 🎯 **Overview**

This section covers the essential tools and techniques that will significantly boost your productivity in AI/ML development. These tools are specifically chosen to work well with your existing development workflow and MacBook M1 setup.

---

## 🚀 **Core Development Tools**

### **1. Code Editors and IDEs**

#### **VS Code with AI Extensions**
```json
{
  "recommendations": [
    "ms-python.python",
    "ms-toolsai.jupyter",
    "ms-python.pylint",
    "ms-python.black-formatter",
    "ms-python.isort",
    "github.copilot",
    "ms-vscode.vscode-json",
    "ms-toolsai.vscode-ai",
    "ms-python.flake8",
    "ms-python.mypy-type-checker",
    "ms-python.debugpy",
    "ms-toolsai.vscode-ai"
  ]
}
```

#### **Cursor (AI-Powered Editor)**
- **GitHub Copilot integration**
- **AI code completion**
- **Natural language to code**
- **Code explanation and documentation**

#### **Jupyter Lab Extensions**
```bash
# Install essential Jupyter extensions
pip install jupyterlab-git
pip install jupyterlab-lsp
pip install jupyterlab-widgets
pip install jupyterlab-drawio
pip install jupyterlab-toc
```

---

### **2. Python Environment Management**

#### **Conda + Poetry Hybrid Approach**
```bash
# System-level packages with Conda
conda create -n ml-dev python=3.11
conda activate ml-dev
conda install numpy scipy pandas matplotlib seaborn

# Project-level dependencies with Poetry
poetry init
poetry add torch torchvision torchaudio
poetry add scikit-learn xgboost lightgbm
poetry add jupyter jupyterlab
```

#### **UV (Ultra-Fast Python Package Manager)**
```bash
# Install UV
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create project with UV
uv init my-ml-project
cd my-ml-project
uv add torch pandas numpy matplotlib

# Run with UV
uv run python train_model.py
```

---

### **3. Experiment Tracking and MLOps**

#### **Weights & Biases (W&B)**
```python
import wandb

# Initialize experiment
wandb.init(
    project="my-ml-project",
    name="experiment-1",
    config={
        "learning_rate": 0.001,
        "batch_size": 32,
        "epochs": 100
    }
)

# Log metrics
wandb.log({"accuracy": 0.95, "loss": 0.05})

# Log model
wandb.log_model(model, "my-model")

# Log plots
wandb.log({"confusion_matrix": wandb.plot.confusion_matrix(
    y_true=y_test, 
    y_pred=y_pred,
    class_names=class_names
)})
```

#### **MLflow**
```python
import mlflow
import mlflow.sklearn
import mlflow.pytorch

# Start experiment
with mlflow.start_run():
    # Train model
    model = train_model()
    
    # Log parameters
    mlflow.log_param("learning_rate", 0.001)
    mlflow.log_param("batch_size", 32)
    
    # Log metrics
    mlflow.log_metric("accuracy", accuracy)
    mlflow.log_metric("f1_score", f1_score)
    
    # Log model
    mlflow.sklearn.log_model(model, "model")
    
    # Log artifacts
    mlflow.log_artifact("confusion_matrix.png")
```

---

## 🛠️ **Data Science Tools**

### **1. Data Manipulation and Analysis**

#### **Pandas Pro Tips**
```python
import pandas as pd
import numpy as np

# Efficient data loading
def load_large_csv(filepath, chunksize=10000):
    """Load large CSV files efficiently"""
    chunks = []
    for chunk in pd.read_csv(filepath, chunksize=chunksize):
        # Process chunk
        processed_chunk = process_chunk(chunk)
        chunks.append(processed_chunk)
    return pd.concat(chunks, ignore_index=True)

# Memory optimization
def optimize_dtypes(df):
    """Optimize DataFrame memory usage"""
    for col in df.columns:
        if df[col].dtype == 'object':
            df[col] = df[col].astype('category')
        elif df[col].dtype == 'int64':
            df[col] = pd.to_numeric(df[col], downcast='integer')
        elif df[col].dtype == 'float64':
            df[col] = pd.to_numeric(df[col], downcast='float')
    return df

# Advanced data analysis
def comprehensive_data_analysis(df):
    """Comprehensive data analysis pipeline"""
    analysis = {
        'shape': df.shape,
        'dtypes': df.dtypes,
        'missing_values': df.isnull().sum(),
        'duplicate_rows': df.duplicated().sum(),
        'memory_usage': df.memory_usage(deep=True).sum(),
        'numeric_summary': df.describe(),
        'categorical_summary': df.select_dtypes(include=['object']).describe()
    }
    return analysis
```

#### **Polars (Fast Alternative to Pandas)**
```python
import polars as pl

# Ultra-fast data processing
df = pl.read_csv("large_dataset.csv")
result = (df
    .filter(pl.col("age") > 18)
    .group_by("category")
    .agg([
        pl.col("value").mean().alias("mean_value"),
        pl.col("value").std().alias("std_value")
    ])
    .sort("mean_value", descending=True)
)
```

---

### **2. Visualization Tools**

#### **Matplotlib + Seaborn**
```python
import matplotlib.pyplot as plt
import seaborn as sns

# Professional plotting setup
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

def create_publication_plots(data, save_path="plots/"):
    """Create publication-ready plots"""
    
    # Correlation heatmap
    plt.figure(figsize=(12, 8))
    correlation_matrix = data.corr()
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', center=0)
    plt.title('Feature Correlation Matrix')
    plt.tight_layout()
    plt.savefig(f"{save_path}correlation_heatmap.png", dpi=300, bbox_inches='tight')
    plt.show()
    
    # Distribution plots
    numeric_cols = data.select_dtypes(include=[np.number]).columns
    fig, axes = plt.subplots(2, 2, figsize=(15, 10))
    axes = axes.ravel()
    
    for i, col in enumerate(numeric_cols[:4]):
        sns.histplot(data[col], ax=axes[i], kde=True)
        axes[i].set_title(f'Distribution of {col}')
    
    plt.tight_layout()
    plt.savefig(f"{save_path}distributions.png", dpi=300, bbox_inches='tight')
    plt.show()
```

#### **Plotly for Interactive Visualizations**
```python
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots

def create_interactive_dashboard(data):
    """Create interactive dashboard"""
    
    # Interactive scatter plot
    fig = px.scatter(
        data, 
        x='feature1', 
        y='feature2', 
        color='target',
        size='importance',
        hover_data=['feature3', 'feature4'],
        title='Interactive Feature Analysis'
    )
    
    # Add trend line
    fig.add_trace(go.Scatter(
        x=data['feature1'],
        y=data['feature2'],
        mode='lines',
        name='Trend Line',
        line=dict(dash='dash')
    ))
    
    fig.show()
```

---

### **3. Machine Learning Libraries**

#### **Scikit-learn with Advanced Features**
```python
from sklearn.model_selection import cross_val_score, GridSearchCV
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.metrics import classification_report, confusion_matrix

def create_ml_pipeline(numeric_features, categorical_features):
    """Create comprehensive ML pipeline"""
    
    # Preprocessing steps
    numeric_transformer = Pipeline(steps=[
        ('scaler', StandardScaler())
    ])
    
    categorical_transformer = Pipeline(steps=[
        ('onehot', OneHotEncoder(handle_unknown='ignore'))
    ])
    
    # Combine preprocessing
    preprocessor = ColumnTransformer(
        transformers=[
            ('num', numeric_transformer, numeric_features),
            ('cat', categorical_transformer, categorical_features)
        ]
    )
    
    # Complete pipeline
    pipeline = Pipeline(steps=[
        ('preprocessor', preprocessor),
        ('classifier', RandomForestClassifier())
    ])
    
    return pipeline

def hyperparameter_tuning(pipeline, X, y, param_grid):
    """Comprehensive hyperparameter tuning"""
    
    grid_search = GridSearchCV(
        pipeline, 
        param_grid, 
        cv=5, 
        scoring='f1_weighted',
        n_jobs=-1,
        verbose=1
    )
    
    grid_search.fit(X, y)
    
    return grid_search.best_estimator_, grid_search.best_params_
```

#### **XGBoost and LightGBM**
```python
import xgboost as xgb
import lightgbm as lgb

def advanced_ensemble_model(X_train, y_train, X_val, y_val):
    """Create advanced ensemble model"""
    
    # XGBoost model
    xgb_model = xgb.XGBClassifier(
        n_estimators=1000,
        max_depth=6,
        learning_rate=0.1,
        subsample=0.8,
        colsample_bytree=0.8,
        random_state=42
    )
    
    # LightGBM model
    lgb_model = lgb.LGBMClassifier(
        n_estimators=1000,
        max_depth=6,
        learning_rate=0.1,
        subsample=0.8,
        colsample_bytree=0.8,
        random_state=42
    )
    
    # Train models
    xgb_model.fit(X_train, y_train, eval_set=[(X_val, y_val)], early_stopping_rounds=50, verbose=False)
    lgb_model.fit(X_train, y_train, eval_set=[(X_val, y_val)], early_stopping_rounds=50, verbose=False)
    
    # Ensemble predictions
    xgb_pred = xgb_model.predict_proba(X_val)[:, 1]
    lgb_pred = lgb_model.predict_proba(X_val)[:, 1]
    
    # Weighted ensemble
    ensemble_pred = 0.6 * xgb_pred + 0.4 * lgb_pred
    
    return ensemble_pred
```

---

## 🔧 **Development Productivity Tools**

### **1. Code Quality and Testing**

#### **Pre-commit Hooks**
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/psf/black
    rev: 22.3.0
    hooks:
      - id: black
        language_version: python3.9

  - repo: https://github.com/pycqa/isort
    rev: 5.10.1
    hooks:
      - id: isort

  - repo: https://github.com/pycqa/flake8
    rev: 4.0.1
    hooks:
      - id: flake8

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v0.950
    hooks:
      - id: mypy
        additional_dependencies: [types-requests, types-PyYAML]
```

#### **Pytest for ML Testing**
```python
import pytest
import numpy as np
from sklearn.model_selection import train_test_split

class TestMLPipeline:
    """Comprehensive ML pipeline testing"""
    
    def test_data_loading(self, sample_data):
        """Test data loading functionality"""
        assert sample_data.shape[0] > 0
        assert sample_data.shape[1] > 0
        assert not sample_data.isnull().all().any()
    
    def test_data_preprocessing(self, sample_data):
        """Test data preprocessing"""
        processed_data = preprocess_data(sample_data)
        assert processed_data.shape[0] == sample_data.shape[0]
        assert not processed_data.isnull().any().any()
    
    def test_model_training(self, X_train, y_train):
        """Test model training"""
        model = train_model(X_train, y_train)
        assert hasattr(model, 'predict')
        assert hasattr(model, 'score')
    
    def test_model_prediction(self, trained_model, X_test):
        """Test model prediction"""
        predictions = trained_model.predict(X_test)
        assert len(predictions) == len(X_test)
        assert all(isinstance(p, (int, float)) for p in predictions)
    
    def test_model_performance(self, trained_model, X_test, y_test):
        """Test model performance"""
        accuracy = trained_model.score(X_test, y_test)
        assert accuracy > 0.5  # Minimum acceptable accuracy
        assert accuracy <= 1.0  # Maximum possible accuracy
```

---

### **2. Documentation and Collaboration**

#### **Jupyter Book for Documentation**
```bash
# Install Jupyter Book
pip install jupyter-book

# Create book structure
jupyter-book create my-ml-book

# Build book
jupyter-book build my-ml-book
```

#### **Git LFS for Large Files**
```bash
# Install Git LFS
git lfs install

# Track large files
git lfs track "*.pkl"
git lfs track "*.h5"
git lfs track "*.bin"
git lfs track "*.pt"
git lfs track "*.pth"

# Add .gitattributes
echo "*.pkl filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
echo "*.h5 filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
echo "*.bin filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
echo "*.pt filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
echo "*.pth filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
```

---

### **3. Performance Monitoring and Profiling**

#### **Memory and Performance Profiling**
```python
import psutil
import time
import memory_profiler
from line_profiler import LineProfiler

@memory_profiler.profile
def train_model_with_profiling(X, y):
    """Train model with memory profiling"""
    model = RandomForestClassifier(n_estimators=100)
    model.fit(X, y)
    return model

def profile_function_performance(func, *args, **kwargs):
    """Profile function performance"""
    profiler = LineProfiler()
    profiler.add_function(func)
    profiler.enable_by_count()
    
    start_time = time.time()
    result = func(*args, **kwargs)
    end_time = time.time()
    
    profiler.disable_by_count()
    profiler.print_stats()
    
    print(f"Execution time: {end_time - start_time:.4f} seconds")
    return result

def monitor_system_resources():
    """Monitor system resources during training"""
    cpu_percent = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory()
    
    print(f"CPU Usage: {cpu_percent}%")
    print(f"Memory Usage: {memory.percent}%")
    print(f"Available Memory: {memory.available / 1024**3:.2f} GB")
```

---

## 🚀 **M1-Specific Productivity Tools**

### **1. M1-Optimized Libraries**

#### **PyTorch with M1 GPU Support**
```python
import torch
import torch.nn as nn
import torch.optim as optim

def setup_m1_device():
    """Setup M1 device for optimal performance"""
    if torch.backends.mps.is_available():
        device = torch.device("mps")
        print("Using M1 GPU (MPS)")
    else:
        device = torch.device("cpu")
        print("Using CPU")
    
    return device

def m1_optimized_training(model, train_loader, val_loader, epochs=100):
    """M1-optimized training loop"""
    device = setup_m1_device()
    model = model.to(device)
    
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.001)
    
    for epoch in range(epochs):
        # Training
        model.train()
        for batch_idx, (data, target) in enumerate(train_loader):
            data, target = data.to(device), target.to(device)
            
            optimizer.zero_grad()
            output = model(data)
            loss = criterion(output, target)
            loss.backward()
            optimizer.step()
        
        # Validation
        model.eval()
        val_loss = 0
        correct = 0
        with torch.no_grad():
            for data, target in val_loader:
                data, target = data.to(device), target.to(device)
                output = model(data)
                val_loss += criterion(output, target).item()
                pred = output.argmax(dim=1, keepdim=True)
                correct += pred.eq(target.view_as(pred)).sum().item()
        
        if epoch % 10 == 0:
            print(f'Epoch {epoch}: Val Loss: {val_loss/len(val_loader):.4f}, Val Acc: {100.*correct/len(val_loader.dataset):.2f}%')
    
    return model
```

#### **TensorFlow with Metal GPU**
```python
import tensorflow as tf

def setup_tensorflow_m1():
    """Setup TensorFlow for M1 optimization"""
    # Configure for M1
    tf.config.experimental.set_memory_growth(
        tf.config.list_physical_devices('GPU')[0], True
    )
    
    # Enable mixed precision
    tf.keras.mixed_precision.set_global_policy('mixed_float16')
    
    print("TensorFlow configured for M1 optimization")

def create_m1_optimized_model(input_shape, num_classes):
    """Create M1-optimized model"""
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(128, activation='relu', input_shape=input_shape),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(64, activation='relu'),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(num_classes, activation='softmax')
    ])
    
    # Compile with M1 optimizations
    model.compile(
        optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
        loss='sparse_categorical_crossentropy',
        metrics=['accuracy']
    )
    
    return model
```

---

### **2. M1 Performance Monitoring**

#### **M1-Specific Performance Tools**
```python
import psutil
import torch
import time

class M1PerformanceMonitor:
    """M1-specific performance monitoring"""
    
    def __init__(self):
        self.start_time = time.time()
        self.memory_usage = []
        self.cpu_usage = []
        self.gpu_usage = []
    
    def log_performance(self):
        """Log current performance metrics"""
        # CPU usage
        cpu_percent = psutil.cpu_percent(interval=1)
        self.cpu_usage.append(cpu_percent)
        
        # Memory usage
        memory = psutil.virtual_memory()
        self.memory_usage.append(memory.percent)
        
        # GPU usage (if available)
        if torch.backends.mps.is_available():
            gpu_memory = torch.mps.current_allocated_memory() / 1024**2  # MB
            self.gpu_usage.append(gpu_memory)
        
        print(f"CPU: {cpu_percent}%, Memory: {memory.percent}%, GPU: {gpu_memory if 'gpu_memory' in locals() else 'N/A'}MB")
    
    def get_performance_summary(self):
        """Get performance summary"""
        total_time = time.time() - self.start_time
        
        return {
            'total_time': total_time,
            'avg_cpu_usage': np.mean(self.cpu_usage),
            'avg_memory_usage': np.mean(self.memory_usage),
            'max_memory_usage': max(self.memory_usage),
            'avg_gpu_usage': np.mean(self.gpu_usage) if self.gpu_usage else 0
        }
```

---

## 📋 **Tool Setup Checklist**

### **Essential Tools**
- [ ] VS Code with AI extensions
- [ ] Cursor (AI-powered editor)
- [ ] Jupyter Lab with extensions
- [ ] Conda + Poetry environment management
- [ ] UV for fast package management

### **ML/AI Tools**
- [ ] Weights & Biases for experiment tracking
- [ ] MLflow for model management
- [ ] PyTorch with M1 support
- [ ] TensorFlow with Metal GPU
- [ ] Scikit-learn with advanced features

### **Development Tools**
- [ ] Pre-commit hooks for code quality
- [ ] Pytest for testing
- [ ] Git LFS for large files
- [ ] Memory and performance profilers
- [ ] M1-specific monitoring tools

### **Documentation Tools**
- [ ] Jupyter Book for documentation
- [ ] Markdown with extensions
- [ ] Mermaid for diagrams
- [ ] Plotly for interactive visualizations

---

## 🎯 **Productivity Tips**

### **1. Keyboard Shortcuts**
- **VS Code**: `Cmd+Shift+P` for command palette
- **Jupyter**: `Shift+Enter` to run cell, `A/B` to add cell above/below
- **Terminal**: `Cmd+T` for new tab, `Cmd+D` for split

### **2. Workflow Optimization**
- Use templates for common project structures
- Automate repetitive tasks with scripts
- Set up aliases for frequently used commands
- Use version control for all projects

### **3. Learning Acceleration**
- Use AI tools for code completion and explanation
- Practice with real datasets and problems
- Join ML communities and forums
- Share your work and get feedback

---

**Remember: The best tools are the ones that fit your workflow and help you focus on solving problems, not fighting with technology.** 🚀

---

**Next:** [07 - AI/ML Basics](07-ai-ml-basics/README.md)