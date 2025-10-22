# 09 - Quick Reference

**Essential cheat sheets, commands, and quick lookup guides for AI/ML development**

---

## 🎯 **Overview**

This section provides quick reference materials for common AI/ML tasks, commands, and concepts. Perfect for experienced developers who need fast access to syntax, patterns, and best practices.

---

## 🐍 **Python Essentials**

### **1. Data Manipulation with Pandas**

#### **Basic Operations**
```python
import pandas as pd
import numpy as np

# Create DataFrame
df = pd.DataFrame({
    'A': [1, 2, 3, 4],
    'B': [5, 6, 7, 8],
    'C': ['a', 'b', 'c', 'd']
})

# Basic info
df.info()
df.describe()
df.head()
df.tail()
df.shape
df.columns
df.index

# Data types
df.dtypes
df.select_dtypes(include=['number'])
df.select_dtypes(include=['object'])

# Missing values
df.isnull().sum()
df.dropna()
df.fillna(value)
df.fillna(method='ffill')

# Duplicates
df.duplicated()
df.drop_duplicates()

# Sorting
df.sort_values('column_name')
df.sort_values(['col1', 'col2'], ascending=[True, False])

# Filtering
df[df['column'] > 5]
df.query('column > 5')
df.loc[df['column'] > 5, 'column']
df.iloc[0:5, 0:3]

# Grouping
df.groupby('column').sum()
df.groupby('column').agg({'col1': 'sum', 'col2': 'mean'})
df.groupby('column').apply(lambda x: x.max() - x.min())

# Pivot tables
df.pivot_table(values='value', index='row', columns='col', aggfunc='mean')
df.pivot_table(values='value', index='row', columns='col', aggfunc='mean', fill_value=0)

# Merging
pd.merge(df1, df2, on='key')
pd.concat([df1, df2], axis=0)  # vertical
pd.concat([df1, df2], axis=1)  # horizontal

# Apply functions
df['new_col'] = df['col'].apply(lambda x: x * 2)
df.apply(lambda x: x.max() - x.min(), axis=1)
df.applymap(lambda x: x * 2)

# String operations
df['col'].str.upper()
df['col'].str.contains('pattern')
df['col'].str.split(' ')
df['col'].str.replace('old', 'new')

# Date operations
df['date_col'] = pd.to_datetime(df['date_col'])
df['year'] = df['date_col'].dt.year
df['month'] = df['date_col'].dt.month
df['day'] = df['date_col'].dt.day
```

#### **Advanced Operations**
```python
# Multi-level indexing
df.set_index(['col1', 'col2'])
df.reset_index()
df.xs('value', level='level_name')

# Reshaping
df.melt(id_vars=['id_col'], value_vars=['col1', 'col2'])
df.pivot(index='row', columns='col', values='value')

# Window functions
df['rolling_mean'] = df['col'].rolling(window=3).mean()
df['expanding_mean'] = df['col'].expanding().mean()
df['rank'] = df['col'].rank()

# Categorical data
df['col'] = df['col'].astype('category')
df['col'].cat.categories
df['col'].cat.add_categories(['new_cat'])
df['col'].cat.remove_categories(['old_cat'])

# Memory optimization
df.memory_usage(deep=True)
df.astype({'col1': 'int32', 'col2': 'float32'})

# Sampling
df.sample(n=100)
df.sample(frac=0.1)
df.nlargest(10, 'column')
df.nsmallest(10, 'column')
```

---

### **2. NumPy Essentials**

#### **Array Operations**
```python
import numpy as np

# Create arrays
np.array([1, 2, 3, 4])
np.zeros((3, 4))
np.ones((3, 4))
np.full((3, 4), 5)
np.eye(3)
np.random.random((3, 4))
np.linspace(0, 1, 5)
np.arange(0, 10, 2)

# Array properties
arr.shape
arr.dtype
arr.size
arr.ndim
arr.itemsize

# Reshaping
arr.reshape(2, 6)
arr.flatten()
arr.ravel()
arr.transpose()
arr.T

# Indexing and slicing
arr[0, 1]
arr[0:2, 1:3]
arr[arr > 5]
arr[arr > 5, :]

# Mathematical operations
np.add(arr1, arr2)
np.subtract(arr1, arr2)
np.multiply(arr1, arr2)
np.divide(arr1, arr2)
np.power(arr1, 2)
np.sqrt(arr)
np.exp(arr)
np.log(arr)
np.sin(arr)
np.cos(arr)

# Statistical functions
np.mean(arr)
np.median(arr)
np.std(arr)
np.var(arr)
np.min(arr)
np.max(arr)
np.argmin(arr)
np.argmax(arr)
np.sum(arr)
np.prod(arr)

# Linear algebra
np.dot(arr1, arr2)
np.matmul(arr1, arr2)
np.linalg.inv(arr)
np.linalg.det(arr)
np.linalg.eig(arr)
np.linalg.svd(arr)

# Broadcasting
arr1 + arr2  # Broadcasting
arr1 * arr2  # Element-wise multiplication
arr1 @ arr2  # Matrix multiplication
```

---

### **3. Matplotlib and Seaborn**

#### **Basic Plotting**
```python
import matplotlib.pyplot as plt
import seaborn as sns

# Set style
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

# Line plot
plt.plot(x, y)
plt.plot(x, y, 'r--', linewidth=2, label='line1')
plt.xlabel('X Label')
plt.ylabel('Y Label')
plt.title('Title')
plt.legend()
plt.grid(True)
plt.show()

# Scatter plot
plt.scatter(x, y, c=colors, s=sizes, alpha=0.6)
plt.scatter(x, y, c=z, cmap='viridis')

# Bar plot
plt.bar(x, y)
plt.barh(x, y)  # horizontal

# Histogram
plt.hist(data, bins=30, alpha=0.7)
plt.hist(data, bins=30, density=True, alpha=0.7)

# Box plot
plt.boxplot(data)
plt.boxplot([data1, data2, data3], labels=['A', 'B', 'C'])

# Subplots
fig, axes = plt.subplots(2, 2, figsize=(12, 8))
axes[0, 0].plot(x, y)
axes[0, 1].scatter(x, y)
axes[1, 0].hist(data)
axes[1, 1].boxplot(data)

# Seaborn plots
sns.scatterplot(x='col1', y='col2', data=df)
sns.lineplot(x='col1', y='col2', data=df)
sns.barplot(x='col1', y='col2', data=df)
sns.histplot(data=df, x='col1')
sns.boxplot(data=df, x='col1', y='col2')
sns.violinplot(data=df, x='col1', y='col2')
sns.heatmap(df.corr(), annot=True)
sns.pairplot(df)
sns.jointplot(x='col1', y='col2', data=df)
sns.facetgrid(df, col='col1', row='col2')
```

---

## 🤖 **Machine Learning with Scikit-learn**

### **1. Data Preprocessing**

#### **Basic Preprocessing**
```python
from sklearn.preprocessing import StandardScaler, MinMaxScaler, LabelEncoder, OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.impute import SimpleImputer

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Scaling
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# MinMax scaling
minmax_scaler = MinMaxScaler()
X_train_minmax = minmax_scaler.fit_transform(X_train)

# Label encoding
le = LabelEncoder()
y_encoded = le.fit_transform(y)

# One-hot encoding
ohe = OneHotEncoder()
X_encoded = ohe.fit_transform(X)

# Imputation
imputer = SimpleImputer(strategy='mean')
X_imputed = imputer.fit_transform(X)

# Pipeline
from sklearn.pipeline import Pipeline
pipeline = Pipeline([
    ('imputer', SimpleImputer(strategy='mean')),
    ('scaler', StandardScaler()),
    ('classifier', RandomForestClassifier())
])
```

#### **Advanced Preprocessing**
```python
from sklearn.preprocessing import PolynomialFeatures, RobustScaler, QuantileTransformer
from sklearn.feature_selection import SelectKBest, f_classif, mutual_info_classif

# Polynomial features
poly = PolynomialFeatures(degree=2)
X_poly = poly.fit_transform(X)

# Robust scaling
robust_scaler = RobustScaler()
X_robust = robust_scaler.fit_transform(X)

# Quantile transformation
qt = QuantileTransformer(output_distribution='normal')
X_qt = qt.fit_transform(X)

# Feature selection
selector = SelectKBest(score_func=f_classif, k=10)
X_selected = selector.fit_transform(X, y)

# Mutual information
mi_scores = mutual_info_classif(X, y)
```

---

### **2. Model Training and Evaluation**

#### **Classification Models**
```python
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, roc_auc_score

# Train models
models = {
    'Logistic Regression': LogisticRegression(random_state=42),
    'Random Forest': RandomForestClassifier(random_state=42),
    'Gradient Boosting': GradientBoostingClassifier(random_state=42),
    'SVM': SVC(random_state=42, probability=True),
    'KNN': KNeighborsClassifier(),
    'Naive Bayes': GaussianNB()
}

for name, model in models.items():
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    y_pred_proba = model.predict_proba(X_test)[:, 1] if hasattr(model, 'predict_proba') else None
    
    print(f"{name}:")
    print(f"  Accuracy: {accuracy_score(y_test, y_pred):.3f}")
    print(f"  Precision: {precision_score(y_test, y_pred):.3f}")
    print(f"  Recall: {recall_score(y_test, y_pred):.3f}")
    print(f"  F1: {f1_score(y_test, y_pred):.3f}")
    if y_pred_proba is not None:
        print(f"  ROC AUC: {roc_auc_score(y_test, y_pred_proba):.3f}")
    print()
```

#### **Regression Models**
```python
from sklearn.linear_model import LinearRegression, Ridge, Lasso
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.svm import SVR
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

# Train models
models = {
    'Linear Regression': LinearRegression(),
    'Ridge': Ridge(alpha=1.0),
    'Lasso': Lasso(alpha=1.0),
    'Random Forest': RandomForestRegressor(random_state=42),
    'Gradient Boosting': GradientBoostingRegressor(random_state=42),
    'SVR': SVR()
}

for name, model in models.items():
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    
    print(f"{name}:")
    print(f"  MSE: {mean_squared_error(y_test, y_pred):.3f}")
    print(f"  MAE: {mean_absolute_error(y_test, y_pred):.3f}")
    print(f"  R²: {r2_score(y_test, y_pred):.3f}")
    print()
```

#### **Cross-Validation**
```python
from sklearn.model_selection import cross_val_score, StratifiedKFold, GridSearchCV

# Cross-validation
cv_scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
print(f"CV scores: {cv_scores}")
print(f"Mean CV score: {cv_scores.mean():.3f} (+/- {cv_scores.std() * 2:.3f})")

# Stratified K-fold
skf = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
stratified_scores = cross_val_score(model, X, y, cv=skf, scoring='accuracy')

# Grid search
param_grid = {
    'n_estimators': [100, 200, 300],
    'max_depth': [10, 20, 30],
    'min_samples_split': [2, 5, 10]
}
grid_search = GridSearchCV(model, param_grid, cv=5, scoring='accuracy')
grid_search.fit(X, y)
print(f"Best parameters: {grid_search.best_params_}")
print(f"Best score: {grid_search.best_score_:.3f}")
```

---

### **3. Model Evaluation**

#### **Classification Metrics**
```python
from sklearn.metrics import classification_report, confusion_matrix, roc_curve, auc
import matplotlib.pyplot as plt

# Classification report
print(classification_report(y_test, y_pred))

# Confusion matrix
cm = confusion_matrix(y_test, y_pred)
print("Confusion Matrix:")
print(cm)

# ROC curve
fpr, tpr, _ = roc_curve(y_test, y_pred_proba)
roc_auc = auc(fpr, tpr)
plt.plot(fpr, tpr, label=f'ROC curve (AUC = {roc_auc:.2f})')
plt.plot([0, 1], [0, 1], 'k--')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('ROC Curve')
plt.legend()
plt.show()
```

#### **Regression Metrics**
```python
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import matplotlib.pyplot as plt

# Metrics
mse = mean_squared_error(y_test, y_pred)
mae = mean_absolute_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print(f"MSE: {mse:.3f}")
print(f"MAE: {mae:.3f}")
print(f"R²: {r2:.3f}")

# Residuals plot
residuals = y_test - y_pred
plt.scatter(y_pred, residuals)
plt.xlabel('Predicted')
plt.ylabel('Residuals')
plt.title('Residuals Plot')
plt.axhline(y=0, color='r', linestyle='--')
plt.show()
```

---

## 🧠 **Deep Learning with PyTorch**

### **1. Basic Neural Network**

#### **Model Definition**
```python
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, TensorDataset

class SimpleNN(nn.Module):
    def __init__(self, input_size, hidden_size, output_size):
        super(SimpleNN, self).__init__()
        self.fc1 = nn.Linear(input_size, hidden_size)
        self.fc2 = nn.Linear(hidden_size, hidden_size)
        self.fc3 = nn.Linear(hidden_size, output_size)
        self.relu = nn.ReLU()
        self.dropout = nn.Dropout(0.2)
    
    def forward(self, x):
        x = self.relu(self.fc1(x))
        x = self.dropout(x)
        x = self.relu(self.fc2(x))
        x = self.dropout(x)
        x = self.fc3(x)
        return x

# Create model
model = SimpleNN(input_size=784, hidden_size=128, output_size=10)
```

#### **Training Loop**
```python
# Loss and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.001)

# Training loop
for epoch in range(100):
    model.train()
    for batch_X, batch_y in train_loader:
        optimizer.zero_grad()
        outputs = model(batch_X)
        loss = criterion(outputs, batch_y)
        loss.backward()
        optimizer.step()
    
    # Validation
    model.eval()
    with torch.no_grad():
        val_loss = 0
        correct = 0
        for batch_X, batch_y in val_loader:
            outputs = model(batch_X)
            val_loss += criterion(outputs, batch_y).item()
            pred = outputs.argmax(dim=1, keepdim=True)
            correct += pred.eq(batch_y.view_as(pred)).sum().item()
    
    if epoch % 10 == 0:
        print(f'Epoch {epoch}: Val Loss: {val_loss/len(val_loader):.4f}, Val Acc: {100.*correct/len(val_loader.dataset):.2f}%')
```

### **2. CNN for Image Classification**

#### **CNN Model**
```python
class CNN(nn.Module):
    def __init__(self, num_classes=10):
        super(CNN, self).__init__()
        self.conv1 = nn.Conv2d(3, 32, kernel_size=3, padding=1)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=3, padding=1)
        self.conv3 = nn.Conv2d(64, 128, kernel_size=3, padding=1)
        
        self.pool = nn.MaxPool2d(2, 2)
        self.dropout = nn.Dropout(0.5)
        
        self.fc1 = nn.Linear(128 * 4 * 4, 512)
        self.fc2 = nn.Linear(512, num_classes)
    
    def forward(self, x):
        x = self.pool(torch.relu(self.conv1(x)))
        x = self.pool(torch.relu(self.conv2(x)))
        x = self.pool(torch.relu(self.conv3(x)))
        
        x = x.view(-1, 128 * 4 * 4)
        x = self.dropout(torch.relu(self.fc1(x)))
        x = self.fc2(x)
        
        return x
```

### **3. M1 GPU Support**

#### **M1 GPU Setup**
```python
# Check M1 GPU availability
if torch.backends.mps.is_available():
    device = torch.device("mps")
    print("Using M1 GPU (MPS)")
else:
    device = torch.device("cpu")
    print("Using CPU")

# Move model and data to device
model = model.to(device)
batch_X = batch_X.to(device)
batch_y = batch_y.to(device)

# Training with M1 GPU
for epoch in range(100):
    model.train()
    for batch_X, batch_y in train_loader:
        batch_X, batch_y = batch_X.to(device), batch_y.to(device)
        
        optimizer.zero_grad()
        outputs = model(batch_X)
        loss = criterion(outputs, batch_y)
        loss.backward()
        optimizer.step()
```

---

## 🔧 **Data Science Tools**

### **1. Jupyter Notebook Shortcuts**

#### **Essential Shortcuts**
```
# Command Mode (press Esc)
A - Add cell above
B - Add cell below
C - Copy cell
V - Paste cell
D, D - Delete cell
Z - Undo cell deletion
M - Convert to Markdown
Y - Convert to Code
R - Convert to Raw
Shift + M - Merge cells

# Edit Mode (press Enter)
Ctrl + A - Select all
Ctrl + Z - Undo
Ctrl + Y - Redo
Ctrl + / - Comment/uncomment
Ctrl + Shift + - - Split cell
Ctrl + Enter - Run cell
Shift + Enter - Run cell and move to next
Alt + Enter - Run cell and insert below
```

### **2. Git Commands for ML Projects**

#### **Essential Git Commands**
```bash
# Initialize repository
git init
git remote add origin <url>

# Basic workflow
git add .
git commit -m "Add ML model"
git push origin main

# Branching
git checkout -b feature/new-model
git checkout main
git merge feature/new-model

# Git LFS for large files
git lfs install
git lfs track "*.pkl"
git lfs track "*.h5"
git lfs track "*.bin"
git add .gitattributes
git commit -m "Add LFS tracking"
```

### **3. Docker for ML Projects**

#### **Dockerfile Template**
```dockerfile
FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy code
COPY . .

# Expose port
EXPOSE 8000

# Run command
CMD ["python", "app.py"]
```

#### **Docker Commands**
```bash
# Build image
docker build -t ml-app .

# Run container
docker run -p 8000:8000 ml-app

# Run with volume
docker run -p 8000:8000 -v $(pwd):/app ml-app

# Run interactively
docker run -it ml-app /bin/bash
```

---

## 📊 **Visualization Quick Reference**

### **1. Matplotlib Styles**
```python
# Available styles
plt.style.available

# Set style
plt.style.use('seaborn-v0_8')
plt.style.use('ggplot')
plt.style.use('fivethirtyeight')

# Custom style
plt.rcParams['figure.figsize'] = (12, 8)
plt.rcParams['font.size'] = 14
plt.rcParams['axes.grid'] = True
```

### **2. Color Palettes**
```python
# Matplotlib colors
colors = ['red', 'blue', 'green', 'orange', 'purple']
colors = ['#FF5733', '#33FF57', '#3357FF', '#FF33F5', '#F5FF33']

# Seaborn palettes
sns.set_palette("husl")
sns.set_palette("Set2")
sns.set_palette("viridis")
sns.set_palette("coolwarm")
```

### **3. Common Plot Types**
```python
# Line plot
plt.plot(x, y, 'o-', label='line1')
plt.plot(x, y2, 's--', label='line2')

# Scatter plot
plt.scatter(x, y, c=z, s=100, alpha=0.6, cmap='viridis')

# Bar plot
plt.bar(x, y, color='skyblue', edgecolor='navy')
plt.barh(x, y, color='lightcoral')

# Histogram
plt.hist(data, bins=30, alpha=0.7, color='skyblue', edgecolor='black')

# Box plot
plt.boxplot([data1, data2, data3], labels=['A', 'B', 'C'])

# Heatmap
plt.imshow(matrix, cmap='coolwarm', interpolation='nearest')
plt.colorbar()
```

---

## 🚀 **Performance Optimization**

### **1. Memory Optimization**
```python
# Reduce memory usage
df = df.astype({'col1': 'int32', 'col2': 'float32'})
df = df.astype({'col3': 'category'})

# Chunk processing
for chunk in pd.read_csv('large_file.csv', chunksize=10000):
    process_chunk(chunk)

# Memory profiling
import psutil
print(f"Memory usage: {psutil.virtual_memory().percent}%")
```

### **2. Speed Optimization**
```python
# Vectorized operations
result = np.array([x**2 for x in data])  # Slow
result = data**2  # Fast

# Use appropriate data structures
from collections import defaultdict
d = defaultdict(list)  # Faster than regular dict for appending

# Parallel processing
from multiprocessing import Pool
with Pool(4) as p:
    results = p.map(process_data, data_chunks)
```

---

## 📋 **Common Error Messages and Solutions**

### **1. Pandas Errors**
```python
# SettingWithCopyWarning
df.loc[df['col'] > 5, 'new_col'] = 10  # Use .loc
df = df.copy()  # Or make a copy

# KeyError
df['col']  # Check if column exists
df.get('col', default_value)  # Use get with default

# MemoryError
df = df.astype('category')  # Convert to category
df = df.select_dtypes(include=['number'])  # Select numeric columns only
```

### **2. Scikit-learn Errors**
```python
# ValueError: Found array with 0 sample(s)
# Check if X and y have the same length
assert len(X) == len(y)

# ValueError: Input contains NaN, infinity or a value too large
# Handle missing values
X = X.fillna(X.mean())
X = X.replace([np.inf, -np.inf], np.nan)

# ConvergenceWarning
# Increase max_iter or adjust learning rate
model = LogisticRegression(max_iter=1000)
```

### **3. PyTorch Errors**
```python
# RuntimeError: Expected tensor for argument #1 'input' to have the same device as tensor for argument #2 'mat1'
# Move tensors to same device
x = x.to(device)
y = y.to(device)

# RuntimeError: size mismatch
# Check tensor dimensions
print(x.shape, y.shape)

# CUDA out of memory
# Reduce batch size or use gradient checkpointing
torch.cuda.empty_cache()
```

---

## 🎯 **Quick Start Templates**

### **1. ML Project Template**
```python
# Project structure
"""
my_ml_project/
├── data/
│   ├── raw/
│   ├── processed/
│   └── external/
├── notebooks/
├── src/
│   ├── data/
│   ├── models/
│   ├── features/
│   └── visualization/
├── models/
├── reports/
├── tests/
├── requirements.txt
├── setup.py
└── README.md
"""

# Basic ML pipeline
def ml_pipeline(X, y):
    # Split data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Preprocess
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    # Train model
    model = RandomForestClassifier(random_state=42)
    model.fit(X_train_scaled, y_train)
    
    # Evaluate
    y_pred = model.predict(X_test_scaled)
    accuracy = accuracy_score(y_test, y_pred)
    
    return model, accuracy
```

### **2. Deep Learning Template**
```python
# Basic training loop
def train_model(model, train_loader, val_loader, epochs=100):
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.001)
    
    for epoch in range(epochs):
        # Training
        model.train()
        for batch_X, batch_y in train_loader:
            optimizer.zero_grad()
            outputs = model(batch_X)
            loss = criterion(outputs, batch_y)
            loss.backward()
            optimizer.step()
        
        # Validation
        model.eval()
        with torch.no_grad():
            val_loss = 0
            correct = 0
            for batch_X, batch_y in val_loader:
                outputs = model(batch_X)
                val_loss += criterion(outputs, batch_y).item()
                pred = outputs.argmax(dim=1, keepdim=True)
                correct += pred.eq(batch_y.view_as(pred)).sum().item()
        
        if epoch % 10 == 0:
            print(f'Epoch {epoch}: Val Loss: {val_loss/len(val_loader):.4f}, Val Acc: {100.*correct/len(val_loader.dataset):.2f}%')
    
    return model
```

---

**Remember: This reference guide is your quick lookup companion. Bookmark it and refer to it whenever you need a quick reminder of syntax, patterns, or best practices.** 🚀

---

**Back to:** [Main README](../README.md)