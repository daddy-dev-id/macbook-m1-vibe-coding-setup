# 07 - AI/ML Basics for Experienced Developers

**Essential AI/ML concepts explained for senior engineers with 25+ years of experience**

---

## 🎯 **Overview**

This section provides a structured introduction to AI/ML fundamentals, specifically designed for experienced software engineers. We'll build on your existing knowledge of algorithms, data structures, and system design to accelerate your understanding of machine learning concepts.

---

## 🧠 **Core Concepts Overview**

### **1. The AI/ML Landscape**

#### **Traditional Programming vs. Machine Learning**
```python
# Traditional Programming
def calculate_tax(income, rate):
    return income * rate

# Machine Learning
def predict_tax_bracket(income, features):
    # Model learns patterns from data
    return model.predict(features)
```

#### **Key Differences**
| Traditional Programming | Machine Learning |
|------------------------|------------------|
| Explicit rules | Learned patterns |
| Deterministic | Probabilistic |
| Input → Logic → Output | Data → Model → Prediction |
| Debugging code | Debugging data and models |
| Performance optimization | Accuracy optimization |

---

### **2. Types of Machine Learning**

#### **Supervised Learning**
```python
# Classification: Predicting categories
def classify_email(text):
    # Input: Email text
    # Output: Spam/Ham
    return model.predict(text)

# Regression: Predicting continuous values
def predict_house_price(features):
    # Input: House features
    # Output: Price
    return model.predict(features)
```

#### **Unsupervised Learning**
```python
# Clustering: Finding groups in data
def segment_customers(customer_data):
    # Input: Customer features
    # Output: Customer segments
    return clustering_model.fit_predict(customer_data)

# Dimensionality Reduction: Reducing feature space
def reduce_dimensions(data):
    # Input: High-dimensional data
    # Output: Lower-dimensional representation
    return pca.fit_transform(data)
```

#### **Reinforcement Learning**
```python
# Learning through interaction
def train_agent(environment):
    # Agent learns optimal actions
    # through trial and error
    return trained_agent
```

---

## 📊 **Data Understanding and Preparation**

### **1. Data Types and Characteristics**

#### **Structured Data**
```python
import pandas as pd
import numpy as np

# Tabular data
data = pd.DataFrame({
    'age': [25, 30, 35, 40],
    'income': [50000, 75000, 90000, 110000],
    'education': ['Bachelor', 'Master', 'PhD', 'Bachelor'],
    'target': [0, 1, 1, 0]
})

# Data types
print("Data types:")
print(data.dtypes)

# Statistical summary
print("Statistical summary:")
print(data.describe())
```

#### **Unstructured Data**
```python
# Text data
text_data = [
    "This is a positive review",
    "I hate this product",
    "Amazing experience!"
]

# Image data
import cv2
image = cv2.imread('image.jpg')
print(f"Image shape: {image.shape}")

# Audio data
import librosa
audio, sr = librosa.load('audio.wav')
print(f"Audio shape: {audio.shape}, Sample rate: {sr}")
```

### **2. Data Quality Assessment**

#### **Common Data Issues**
```python
def assess_data_quality(df):
    """Comprehensive data quality assessment"""
    
    quality_report = {
        'shape': df.shape,
        'missing_values': df.isnull().sum(),
        'duplicate_rows': df.duplicated().sum(),
        'data_types': df.dtypes.value_counts(),
        'memory_usage': df.memory_usage(deep=True).sum(),
        'outliers': detect_outliers(df),
        'correlations': df.corr()
    }
    
    return quality_report

def detect_outliers(df, threshold=3):
    """Detect outliers using Z-score"""
    from scipy import stats
    
    outliers = {}
    for col in df.select_dtypes(include=[np.number]).columns:
        z_scores = np.abs(stats.zscore(df[col].dropna()))
        outliers[col] = len(z_scores[z_scores > threshold])
    
    return outliers
```

#### **Data Cleaning Strategies**
```python
def clean_data(df):
    """Comprehensive data cleaning pipeline"""
    
    # Handle missing values
    df_cleaned = df.copy()
    
    # For numerical columns
    numerical_cols = df_cleaned.select_dtypes(include=[np.number]).columns
    df_cleaned[numerical_cols] = df_cleaned[numerical_cols].fillna(
        df_cleaned[numerical_cols].median()
    )
    
    # For categorical columns
    categorical_cols = df_cleaned.select_dtypes(include=['object']).columns
    df_cleaned[categorical_cols] = df_cleaned[categorical_cols].fillna(
        df_cleaned[categorical_cols].mode().iloc[0]
    )
    
    # Remove duplicates
    df_cleaned = df_cleaned.drop_duplicates()
    
    # Handle outliers
    for col in numerical_cols:
        Q1 = df_cleaned[col].quantile(0.25)
        Q3 = df_cleaned[col].quantile(0.75)
        IQR = Q3 - Q1
        lower_bound = Q1 - 1.5 * IQR
        upper_bound = Q3 + 1.5 * IQR
        df_cleaned = df_cleaned[
            (df_cleaned[col] >= lower_bound) & 
            (df_cleaned[col] <= upper_bound)
        ]
    
    return df_cleaned
```

---

## 🤖 **Machine Learning Algorithms**

### **1. Linear Models**

#### **Linear Regression**
```python
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

def linear_regression_example(X, y):
    """Linear regression example"""
    
    # Split data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Train model
    model = LinearRegression()
    model.fit(X_train, y_train)
    
    # Make predictions
    y_pred = model.predict(X_test)
    
    # Evaluate
    mse = mean_squared_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)
    
    print(f"Mean Squared Error: {mse:.2f}")
    print(f"R² Score: {r2:.2f}")
    
    return model
```

#### **Logistic Regression**
```python
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix

def logistic_regression_example(X, y):
    """Logistic regression example"""
    
    # Split data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Train model
    model = LogisticRegression(random_state=42)
    model.fit(X_train, y_train)
    
    # Make predictions
    y_pred = model.predict(X_test)
    y_pred_proba = model.predict_proba(X_test)[:, 1]
    
    # Evaluate
    print("Classification Report:")
    print(classification_report(y_test, y_pred))
    
    print("Confusion Matrix:")
    print(confusion_matrix(y_test, y_pred))
    
    return model
```

### **2. Tree-Based Models**

#### **Decision Trees**
```python
from sklearn.tree import DecisionTreeClassifier, plot_tree
import matplotlib.pyplot as plt

def decision_tree_example(X, y):
    """Decision tree example"""
    
    # Train model
    model = DecisionTreeClassifier(
        max_depth=5,
        min_samples_split=10,
        min_samples_leaf=5,
        random_state=42
    )
    model.fit(X, y)
    
    # Visualize tree
    plt.figure(figsize=(15, 10))
    plot_tree(model, feature_names=X.columns, class_names=['Class 0', 'Class 1'], filled=True)
    plt.title('Decision Tree Visualization')
    plt.show()
    
    # Feature importance
    feature_importance = pd.DataFrame({
        'feature': X.columns,
        'importance': model.feature_importances_
    }).sort_values('importance', ascending=False)
    
    print("Feature Importance:")
    print(feature_importance)
    
    return model
```

#### **Random Forest**
```python
from sklearn.ensemble import RandomForestClassifier

def random_forest_example(X, y):
    """Random forest example"""
    
    # Train model
    model = RandomForestClassifier(
        n_estimators=100,
        max_depth=10,
        min_samples_split=5,
        min_samples_leaf=2,
        random_state=42
    )
    model.fit(X, y)
    
    # Feature importance
    feature_importance = pd.DataFrame({
        'feature': X.columns,
        'importance': model.feature_importances_
    }).sort_values('importance', ascending=False)
    
    print("Feature Importance:")
    print(feature_importance)
    
    return model
```

### **3. Neural Networks**

#### **Basic Neural Network with PyTorch**
```python
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, TensorDataset

class SimpleNN(nn.Module):
    """Simple neural network"""
    
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

def train_neural_network(X, y, epochs=100):
    """Train neural network"""
    
    # Convert to tensors
    X_tensor = torch.FloatTensor(X.values)
    y_tensor = torch.LongTensor(y.values)
    
    # Create dataset and dataloader
    dataset = TensorDataset(X_tensor, y_tensor)
    dataloader = DataLoader(dataset, batch_size=32, shuffle=True)
    
    # Initialize model
    model = SimpleNN(X.shape[1], 64, len(y.unique()))
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.001)
    
    # Training loop
    for epoch in range(epochs):
        for batch_X, batch_y in dataloader:
            optimizer.zero_grad()
            outputs = model(batch_X)
            loss = criterion(outputs, batch_y)
            loss.backward()
            optimizer.step()
        
        if epoch % 10 == 0:
            print(f'Epoch {epoch}, Loss: {loss.item():.4f}')
    
    return model
```

---

## 📈 **Model Evaluation and Validation**

### **1. Cross-Validation**

#### **K-Fold Cross-Validation**
```python
from sklearn.model_selection import cross_val_score, StratifiedKFold

def cross_validation_example(X, y, model):
    """Cross-validation example"""
    
    # K-fold cross-validation
    cv_scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
    
    print(f"Cross-validation scores: {cv_scores}")
    print(f"Mean CV score: {cv_scores.mean():.3f} (+/- {cv_scores.std() * 2:.3f})")
    
    # Stratified K-fold for imbalanced data
    skf = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
    stratified_scores = cross_val_score(model, X, y, cv=skf, scoring='accuracy')
    
    print(f"Stratified CV scores: {stratified_scores}")
    print(f"Mean Stratified CV score: {stratified_scores.mean():.3f}")
    
    return cv_scores, stratified_scores
```

### **2. Evaluation Metrics**

#### **Classification Metrics**
```python
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, roc_auc_score

def classification_metrics(y_true, y_pred, y_pred_proba=None):
    """Comprehensive classification metrics"""
    
    metrics = {
        'accuracy': accuracy_score(y_true, y_pred),
        'precision': precision_score(y_true, y_pred, average='weighted'),
        'recall': recall_score(y_true, y_pred, average='weighted'),
        'f1_score': f1_score(y_true, y_pred, average='weighted')
    }
    
    if y_pred_proba is not None:
        metrics['roc_auc'] = roc_auc_score(y_true, y_pred_proba)
    
    return metrics

def plot_confusion_matrix(y_true, y_pred, class_names):
    """Plot confusion matrix"""
    from sklearn.metrics import confusion_matrix
    import seaborn as sns
    
    cm = confusion_matrix(y_true, y_pred)
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', 
                xticklabels=class_names, yticklabels=class_names)
    plt.title('Confusion Matrix')
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.show()
```

#### **Regression Metrics**
```python
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

def regression_metrics(y_true, y_pred):
    """Comprehensive regression metrics"""
    
    metrics = {
        'mae': mean_absolute_error(y_true, y_pred),
        'mse': mean_squared_error(y_true, y_pred),
        'rmse': np.sqrt(mean_squared_error(y_true, y_pred)),
        'r2': r2_score(y_true, y_pred)
    }
    
    return metrics

def plot_regression_results(y_true, y_pred):
    """Plot regression results"""
    plt.figure(figsize=(10, 6))
    plt.scatter(y_true, y_pred, alpha=0.6)
    plt.plot([y_true.min(), y_true.max()], [y_true.min(), y_true.max()], 'r--', lw=2)
    plt.xlabel('Actual')
    plt.ylabel('Predicted')
    plt.title('Actual vs Predicted')
    plt.show()
```

---

## 🔧 **Feature Engineering**

### **1. Feature Creation**

#### **Numerical Features**
```python
def create_numerical_features(df):
    """Create numerical features"""
    
    # Basic transformations
    df['log_income'] = np.log1p(df['income'])
    df['sqrt_age'] = np.sqrt(df['age'])
    df['income_per_age'] = df['income'] / df['age']
    
    # Polynomial features
    df['age_squared'] = df['age'] ** 2
    df['income_squared'] = df['income'] ** 2
    
    # Binning
    df['age_group'] = pd.cut(df['age'], bins=5, labels=['Young', 'Adult', 'Middle', 'Senior', 'Elderly'])
    df['income_level'] = pd.qcut(df['income'], q=3, labels=['Low', 'Medium', 'High'])
    
    return df
```

#### **Categorical Features**
```python
def create_categorical_features(df):
    """Create categorical features"""
    
    # One-hot encoding
    df_encoded = pd.get_dummies(df, columns=['education', 'marital_status'])
    
    # Label encoding
    from sklearn.preprocessing import LabelEncoder
    le = LabelEncoder()
    df['education_encoded'] = le.fit_transform(df['education'])
    
    # Target encoding
    def target_encode(df, categorical_col, target_col):
        target_mean = df.groupby(categorical_col)[target_col].mean()
        df[f'{categorical_col}_target_encoded'] = df[categorical_col].map(target_mean)
        return df
    
    return df_encoded
```

### **2. Feature Selection**

#### **Statistical Methods**
```python
from sklearn.feature_selection import SelectKBest, f_classif, mutual_info_classif

def feature_selection_example(X, y):
    """Feature selection example"""
    
    # Univariate selection
    selector = SelectKBest(score_func=f_classif, k=10)
    X_selected = selector.fit_transform(X, y)
    
    # Get selected features
    selected_features = X.columns[selector.get_support()]
    print(f"Selected features: {selected_features.tolist()}")
    
    # Mutual information
    mi_scores = mutual_info_classif(X, y)
    mi_df = pd.DataFrame({
        'feature': X.columns,
        'mi_score': mi_scores
    }).sort_values('mi_score', ascending=False)
    
    print("Mutual Information Scores:")
    print(mi_df.head(10))
    
    return X_selected, selected_features
```

---

## 🚀 **Deep Learning Fundamentals**

### **1. Neural Network Architecture**

#### **Feedforward Networks**
```python
class FeedforwardNN(nn.Module):
    """Feedforward neural network"""
    
    def __init__(self, input_size, hidden_sizes, output_size, dropout_rate=0.2):
        super(FeedforwardNN, self).__init__()
        
        layers = []
        prev_size = input_size
        
        for hidden_size in hidden_sizes:
            layers.append(nn.Linear(prev_size, hidden_size))
            layers.append(nn.ReLU())
            layers.append(nn.Dropout(dropout_rate))
            prev_size = hidden_size
        
        layers.append(nn.Linear(prev_size, output_size))
        
        self.network = nn.Sequential(*layers)
    
    def forward(self, x):
        return self.network(x)
```

#### **Convolutional Neural Networks**
```python
class CNN(nn.Module):
    """Convolutional Neural Network for image classification"""
    
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

### **2. Training Techniques**

#### **Regularization**
```python
def train_with_regularization(model, train_loader, val_loader, epochs=100):
    """Train model with regularization techniques"""
    
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.001, weight_decay=1e-4)
    scheduler = optim.lr_scheduler.ReduceLROnPlateau(optimizer, 'min', patience=10)
    
    train_losses = []
    val_losses = []
    
    for epoch in range(epochs):
        # Training
        model.train()
        train_loss = 0
        for batch_X, batch_y in train_loader:
            optimizer.zero_grad()
            outputs = model(batch_X)
            loss = criterion(outputs, batch_y)
            loss.backward()
            optimizer.step()
            train_loss += loss.item()
        
        # Validation
        model.eval()
        val_loss = 0
        with torch.no_grad():
            for batch_X, batch_y in val_loader:
                outputs = model(batch_X)
                loss = criterion(outputs, batch_y)
                val_loss += loss.item()
        
        train_losses.append(train_loss / len(train_loader))
        val_losses.append(val_loss / len(val_loader))
        
        scheduler.step(val_losses[-1])
        
        if epoch % 10 == 0:
            print(f'Epoch {epoch}: Train Loss: {train_losses[-1]:.4f}, Val Loss: {val_losses[-1]:.4f}')
    
    return train_losses, val_losses
```

---

## 📊 **Model Interpretation and Explainability**

### **1. Feature Importance**

#### **Tree-based Feature Importance**
```python
def plot_feature_importance(model, feature_names, top_n=10):
    """Plot feature importance for tree-based models"""
    
    importance = model.feature_importances_
    indices = np.argsort(importance)[::-1][:top_n]
    
    plt.figure(figsize=(10, 6))
    plt.title(f"Top {top_n} Feature Importance")
    plt.bar(range(top_n), importance[indices])
    plt.xticks(range(top_n), [feature_names[i] for i in indices], rotation=45)
    plt.tight_layout()
    plt.show()
```

#### **SHAP Values**
```python
import shap

def explain_model_with_shap(model, X, feature_names):
    """Explain model using SHAP values"""
    
    # Create SHAP explainer
    explainer = shap.TreeExplainer(model)
    shap_values = explainer.shap_values(X)
    
    # Summary plot
    shap.summary_plot(shap_values, X, feature_names=feature_names)
    
    # Waterfall plot for individual prediction
    shap.waterfall_plot(explainer.expected_value, shap_values[0], X.iloc[0], feature_names=feature_names)
    
    return explainer, shap_values
```

---

## 🎯 **Best Practices and Common Patterns**

### **1. Model Selection Strategy**

```python
def model_selection_pipeline(X, y):
    """Comprehensive model selection pipeline"""
    
    from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
    from sklearn.svm import SVC
    from sklearn.linear_model import LogisticRegression
    
    models = {
        'Logistic Regression': LogisticRegression(random_state=42),
        'Random Forest': RandomForestClassifier(random_state=42),
        'Gradient Boosting': GradientBoostingClassifier(random_state=42),
        'SVM': SVC(random_state=42, probability=True)
    }
    
    results = {}
    
    for name, model in models.items():
        # Cross-validation
        cv_scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
        
        results[name] = {
            'mean_score': cv_scores.mean(),
            'std_score': cv_scores.std(),
            'model': model
        }
    
    # Select best model
    best_model_name = max(results.keys(), key=lambda x: results[x]['mean_score'])
    best_model = results[best_model_name]['model']
    
    print(f"Best model: {best_model_name}")
    print(f"Best score: {results[best_model_name]['mean_score']:.3f}")
    
    return best_model, results
```

### **2. Hyperparameter Tuning**

```python
from sklearn.model_selection import GridSearchCV, RandomizedSearchCV

def hyperparameter_tuning(model, param_grid, X, y):
    """Hyperparameter tuning with grid search"""
    
    # Grid search
    grid_search = GridSearchCV(
        model, 
        param_grid, 
        cv=5, 
        scoring='accuracy',
        n_jobs=-1,
        verbose=1
    )
    
    grid_search.fit(X, y)
    
    print(f"Best parameters: {grid_search.best_params_}")
    print(f"Best score: {grid_search.best_score_:.3f}")
    
    return grid_search.best_estimator_
```

---

## 📋 **Learning Path Checklist**

### **Week 1-2: Fundamentals**
- [ ] Understand the difference between traditional programming and ML
- [ ] Learn about different types of machine learning
- [ ] Practice with basic data manipulation and visualization
- [ ] Implement simple linear models

### **Week 3-4: Algorithms**
- [ ] Master tree-based algorithms (Decision Trees, Random Forest)
- [ ] Learn about ensemble methods
- [ ] Practice with neural networks
- [ ] Understand model evaluation metrics

### **Week 5-6: Advanced Topics**
- [ ] Learn feature engineering techniques
- [ ] Practice hyperparameter tuning
- [ ] Understand model interpretation
- [ ] Learn about overfitting and regularization

### **Week 7-8: Practical Application**
- [ ] Complete end-to-end ML project
- [ ] Practice with real datasets
- [ ] Learn about model deployment
- [ ] Understand MLOps practices

---

## 🎯 **Key Takeaways**

1. **Start Simple**: Begin with basic algorithms before moving to complex ones
2. **Data is King**: Invest time in understanding and preparing your data
3. **Validate Everything**: Use proper cross-validation and holdout sets
4. **Interpret Results**: Always try to understand what your model is learning
5. **Iterate and Improve**: ML is an iterative process of experimentation
6. **Learn from Failures**: Failed experiments teach you more than successful ones
7. **Stay Updated**: The field evolves rapidly, keep learning new techniques

---

**Remember: Your 25+ years of experience in software development gives you a solid foundation. The key is to adapt your existing skills to the probabilistic and data-driven nature of machine learning.** 🚀

---

**Next:** [08 - Transition Strategies](08-transition-strategies/README.md)