# ⚡ MacBook Air Quick Migration Guide

**Fast Track: Essential MacBook Pro to MacBook Air Transfer**

---

## 🚀 **Quick Start (30 minutes)**

### **Step 1: Prepare MacBook Pro (5 minutes)**
```bash
# Export essential data
brew list --cask > ~/Desktop/apps-cask.txt
brew list > ~/Desktop/apps-brew.txt
security export -k ~/Library/Keychains/login.keychain -f keychain -o ~/Desktop/keychain.keychain
```

### **Step 2: Use Migration Assistant (20 minutes)**
1. **MacBook Air:** Open Migration Assistant
2. **MacBook Pro:** Open Migration Assistant
3. **Select:** Applications + User Account + Network Settings
4. **Wait:** Let it complete

### **Step 3: Install Missing Apps (5 minutes)**
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install apps
brew install --cask $(cat ~/Desktop/apps-cask.txt)
brew install $(cat ~/Desktop/apps-brew.txt)
```

---

## 🔐 **Browser Data Transfer**

### **Chrome (2 minutes)**
1. **Sign in** to Google account
2. **Enable sync** for all data
3. **Wait** for sync to complete
4. **Verify** bookmarks, passwords, extensions

### **Safari (2 minutes)**
1. **Sign in** to Apple ID
2. **Enable** iCloud for Safari
3. **Wait** for sync to complete
4. **Verify** bookmarks, passwords, reading list

### **Firefox (2 minutes)**
1. **Sign in** to Firefox account
2. **Enable sync** for all data
3. **Wait** for sync to complete
4. **Verify** bookmarks, passwords, extensions

---

## 🛠️ **Development Environment (10 minutes)**

### **SSH Keys**
```bash
# Copy SSH keys
scp -r ~/.ssh user@macbook-air:~/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
```

### **Git Configuration**
```bash
# Copy Git config
scp ~/.gitconfig user@macbook-air:~/

# Test SSH connection
ssh -T git@github.com
```

### **VS Code Settings**
1. **Sign in** to GitHub
2. **Enable** Settings Sync
3. **Wait** for sync to complete
4. **Verify** extensions and settings

---

## 📱 **Essential Apps to Install**

### **Productivity**
- Alfred 5
- Raycast
- Rectangle
- CopyClip

### **Development**
- VS Code
- Cursor
- Docker Desktop
- Postman

### **Design**
- Figma
- Sketch
- Canva

### **Communication**
- Slack
- Discord
- WhatsApp

---

## 🔍 **Quick Verification**

### **System Check**
- [ ] Wi-Fi connected
- [ ] Touch ID working
- [ ] System preferences restored
- [ ] Dock configured

### **App Check**
- [ ] All apps launching
- [ ] Settings restored
- [ ] Licenses activated

### **Browser Check**
- [ ] Bookmarks visible
- [ ] Passwords working
- [ ] Extensions installed
- [ ] Sync enabled

### **Development Check**
- [ ] SSH keys working
- [ ] Git configured
- [ ] VS Code synced
- [ ] Terminal configured

---

## 🚨 **Quick Fixes**

### **App Not Working**
```bash
# Reinstall app
brew reinstall --cask [app-name]

# Reset permissions
sudo tccutil reset All
```

### **Passwords Not Working**
```bash
# Import keychain
security import ~/Desktop/keychain.keychain -k ~/Library/Keychains/login.keychain
```

### **Network Issues**
```bash
# Reset network
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

---

## 📊 **Time Estimates**

| Task | Time |
|------|------|
| Migration Assistant | 20 min |
| App Installation | 10 min |
| Browser Setup | 5 min |
| Development Setup | 10 min |
| Verification | 5 min |
| **Total** | **50 min** |

---

## 🎯 **Success Criteria**

✅ **All apps working**  
✅ **Browser data synced**  
✅ **Development environment ready**  
✅ **Passwords accessible**  
✅ **Network configured**  
✅ **User preferences restored**  

---

**Ready for quick MacBook Air migration! ⚡**