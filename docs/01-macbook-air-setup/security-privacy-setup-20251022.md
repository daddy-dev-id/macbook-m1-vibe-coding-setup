# 🔒 Security & Privacy Setup Guide

**Comprehensive security and privacy configuration for MacBook Air M1**

**Date:** October 22, 2025  
**Target:** MacBook Air M1 Security Hardening  
**Focus:** Complete security and privacy protection

---

## 🎯 **Security Overview**

### **Security Layers:**
1. **System Security** - macOS security features
2. **Network Security** - Firewall, VPN, network protection
3. **Data Security** - Encryption, keychain, password management
4. **Application Security** - App permissions, sandboxing
5. **User Security** - Authentication, 2FA, biometrics

---

## 🛡️ **System Security Configuration**

### **1. FileVault Encryption**
```bash
# Enable FileVault disk encryption
sudo fdesetup enable

# Check FileVault status
sudo fdesetup status

# Verify encryption is active
diskutil info / | grep "Encrypted"
```

### **2. System Integrity Protection (SIP)**
```bash
# Check SIP status
csrutil status

# If disabled, enable SIP (requires Recovery Mode)
# Boot to Recovery Mode: Cmd+R
# Terminal: csrutil enable
```

### **3. Gatekeeper Configuration**
```bash
# Check Gatekeeper status
spctl --status

# Allow apps from identified developers
sudo spctl --master-enable

# Check specific app
spctl --assess --verbose /Applications/AppName.app
```

### **4. System Updates**
```bash
# Check for updates
softwareupdate -l

# Install all updates
sudo softwareupdate -i -a

# Enable automatic updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
```

---

## 🔐 **Authentication & Access Control**

### **1. User Account Security**
```bash
# Create strong password policy
sudo pwpolicy -u daddy.dev -setpolicy "minChars=12 requiresNumeric=1 requiresAlpha=1 requiresSymbol=1"

# Enable automatic login lock
sudo defaults write /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin -bool true

# Set screen lock timeout
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
```

### **2. Touch ID Configuration**
- **System Preferences** > **Touch ID**
- **Enable:** Unlock Mac, Apple Pay, App Store, Password AutoFill
- **Add fingerprints:** Multiple fingers for redundancy

### **3. Two-Factor Authentication**
```bash
# Enable 2FA for Apple ID
# System Preferences > Apple ID > Password & Security > Two-Factor Authentication

# Install authenticator apps
brew install --cask authy
brew install --cask 1password  # Already installed
```

---

## 🔑 **Password & Keychain Security**

### **1. Keychain Configuration**
```bash
# Set keychain timeout
defaults write com.apple.keychainaccess KeychainTimeout -int 3600

# Enable keychain sync
# System Preferences > Apple ID > iCloud > Keychain

# Backup keychain
security export -k ~/Library/Keychains/login.keychain -f keychain -o ~/Desktop/keychain-backup.keychain
```

### **2. Password Management**
```bash
# Install password managers
brew install --cask 1password     # Already installed
brew install --cask bitwarden      # Open source alternative
brew install --cask lastpass       # Another option

# Install password generators
brew install pwgen
brew install apg
```

### **3. SSH Key Security**
```bash
# Generate new SSH key with passphrase
ssh-keygen -t ed25519 -C "your.email@example.com" -f ~/.ssh/id_ed25519_secure

# Set proper permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519_secure
chmod 644 ~/.ssh/id_ed25519_secure.pub

# Add to SSH agent
ssh-add ~/.ssh/id_ed25519_secure
```

---

## 🌐 **Network Security**

### **1. Firewall Configuration**
```bash
# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Check firewall status
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Enable stealth mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
```

### **2. VPN Setup**
```bash
# Install VPN clients
brew install --cask nordvpn
brew install --cask protonvpn
brew install --cask tunnelbear
brew install --cask expressvpn

# Configure built-in VPN
# System Preferences > Network > + > VPN
```

### **3. DNS Security**
```bash
# Install DNS over HTTPS
brew install cloudflared

# Configure DNS servers
# System Preferences > Network > Advanced > DNS
# Add: 1.1.1.1, 1.0.0.1 (Cloudflare)
# Add: 8.8.8.8, 8.8.4.4 (Google)
```

---

## 🔒 **Application Security**

### **1. App Permissions**
```bash
# Reset app permissions
sudo tccutil reset All

# Check specific app permissions
tccutil reset Camera com.apple.PhotoBooth
tccutil reset Microphone com.apple.PhotoBooth
tccutil reset Location com.apple.PhotoBooth
```

### **2. Sandboxing**
```bash
# Check app sandboxing
codesign -dv --entitlements - /Applications/AppName.app

# Verify code signing
codesign -vvv /Applications/AppName.app
```

### **3. Malware Protection**
```bash
# Install antivirus
brew install --cask malwarebytes
brew install --cask bitdefender
brew install --cask norton

# Enable XProtect
# System Preferences > Security & Privacy > General
```

---

## 📱 **Privacy Configuration**

### **1. System Privacy Settings**
```bash
# Disable location services for system services
sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 0

# Disable analytics
sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool false
sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmitVersion -int 4

# Disable Siri
sudo defaults write com.apple.Siri StatusMenuVisible -bool false
sudo defaults write com.apple.Siri VoiceTriggerEnabled -bool false
```

### **2. Browser Privacy**
```bash
# Safari privacy settings
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Chrome privacy settings
defaults write com.google.Chrome DisableExtensions -bool false
defaults write com.google.Chrome DisablePlugins -bool false
defaults write com.google.Chrome DisablePluginsDiscovery -bool false
```

### **3. Data Collection**
```bash
# Disable data collection
sudo defaults write /Library/Preferences/com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false
```

---

## 🔍 **Monitoring & Logging**

### **1. System Monitoring**
```bash
# Install monitoring tools
brew install --cask istat-menus
brew install --cask activity-monitor
brew install --cask coconutbattery

# Enable system logging
sudo log config --mode "level:debug" --subsystem com.apple.security
```

### **2. Network Monitoring**
```bash
# Install network tools
brew install --cask wireshark
brew install --cask little-snitch
brew install --cask lulu

# Monitor network connections
netstat -an | grep LISTEN
lsof -i -P -n | grep LISTEN
```

### **3. File Integrity Monitoring**
```bash
# Install file monitoring
brew install --cask fsmonitor
brew install --cask filemonitor

# Monitor critical directories
sudo fs_usage -w -f filesys | grep -E "(Documents|Desktop|Downloads)"
```

---

## 🚨 **Incident Response**

### **1. Backup & Recovery**
```bash
# Create security backup
sudo ditto /System/Library/Keychains /Volumes/Backup/SystemKeychains
sudo ditto /Library/Keychains /Volumes/Backup/LibraryKeychains
sudo ditto ~/Library/Keychains /Volumes/Backup/UserKeychains

# Test recovery
security import /Volumes/Backup/UserKeychains/login.keychain
```

### **2. Emergency Procedures**
```bash
# Disable network access
sudo ifconfig en0 down

# Lock system
pmset displaysleepnow

# Log out user
osascript -e 'tell application "System Events" to log out'
```

### **3. Security Audit**
```bash
# Run security audit
sudo security audit -s

# Check for suspicious processes
ps aux | grep -E "(crypto|mining|bitcoin)"

# Check network connections
netstat -an | grep -E "(ESTABLISHED|LISTEN)"
```

---

## 📋 **Security Checklist**

### **System Security:**
- [ ] FileVault enabled
- [ ] SIP enabled
- [ ] Gatekeeper enabled
- [ ] Automatic updates enabled
- [ ] Screen lock configured

### **Authentication:**
- [ ] Strong password policy
- [ ] Touch ID configured
- [ ] 2FA enabled for Apple ID
- [ ] Authenticator apps installed

### **Network Security:**
- [ ] Firewall enabled
- [ ] VPN configured
- [ ] DNS security enabled
- [ ] Network monitoring active

### **Application Security:**
- [ ] App permissions reviewed
- [ ] Malware protection installed
- [ ] Code signing verified
- [ ] Sandboxing enabled

### **Privacy:**
- [ ] Location services configured
- [ ] Analytics disabled
- [ ] Data collection minimized
- [ ] Browser privacy enabled

---

## 🎯 **Security Recommendations**

### **High Priority:**
1. **Enable FileVault** - Disk encryption
2. **Set up 2FA** - Two-factor authentication
3. **Install password manager** - 1Password or Bitwarden
4. **Enable firewall** - Network protection
5. **Update system** - Latest security patches

### **Medium Priority:**
1. **Configure VPN** - Network privacy
2. **Review app permissions** - Privacy control
3. **Install antivirus** - Malware protection
4. **Monitor network** - Suspicious activity
5. **Backup keychain** - Recovery preparation

### **Low Priority:**
1. **Advanced monitoring** - System logs
2. **File integrity** - Change detection
3. **Incident response** - Emergency procedures
4. **Security audit** - Regular assessment
5. **Privacy hardening** - Advanced settings

---

## 🚀 **Quick Security Setup**

### **Essential Security (15 minutes):**
```bash
#!/bin/bash
# Essential security setup

echo "🔒 Setting up essential security..."

# Enable FileVault
sudo fdesetup enable

# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable stealth mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Set screen lock
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Install password manager
brew install --cask 1password

# Install authenticator
brew install --cask authy

echo "✅ Essential security setup complete!"
```

### **Complete Security (30 minutes):**
```bash
#!/bin/bash
# Complete security setup

echo "🔒 Setting up complete security..."

# System security
sudo fdesetup enable
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Install security tools
brew install --cask 1password authy bitwarden
brew install --cask nordvpn protonvpn
brew install --cask malwarebytes bitdefender
brew install --cask istat-menus little-snitch

# Configure privacy
sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 0
sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool false

echo "✅ Complete security setup finished!"
```

---

**Your MacBook Air is now secure and privacy-focused! 🔒✨**