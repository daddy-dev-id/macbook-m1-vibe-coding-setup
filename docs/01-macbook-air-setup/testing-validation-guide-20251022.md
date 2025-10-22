# 🧪 Testing & Validation Guide

**Comprehensive testing procedures for MacBook Air setup verification**

**Date:** October 22, 2025  
**Target:** MacBook Air M1 Setup Validation  
**Focus:** Complete system testing and functionality verification

---

## 🎯 **Testing Overview**

### **Testing Phases:**
1. **System Testing** - Hardware and macOS functionality
2. **Application Testing** - Installed apps and tools
3. **Development Testing** - Development environment
4. **Performance Testing** - System performance and benchmarks
5. **Integration Testing** - End-to-end workflows
6. **Security Testing** - Security and privacy verification

### **Testing Methods:**
- **Automated Testing** - Scripts and tools
- **Manual Testing** - User interaction testing
- **Performance Testing** - Benchmarks and metrics
- **Compatibility Testing** - App and tool compatibility

---

## 🖥️ **System Testing**

### **1. Hardware Verification**
```bash
# Check system information
system_profiler SPHardwareDataType
system_profiler SPDisplaysDataType
system_profiler SPMemoryDataType
system_profiler SPStorageDataType

# Verify M1 chip
uname -m
arch
sysctl -n machdep.cpu.brand_string

# Check memory
system_profiler SPMemoryDataType | grep -E "(Size|Type|Speed)"
```

### **2. macOS Functionality**
```bash
# Check macOS version
sw_vers
system_profiler SPSoftwareDataType

# Verify system integrity
sudo spctl --assess --verbose /
sudo spctl --status

# Check system permissions
sudo tccutil reset All
```

### **3. Network Connectivity**
```bash
# Test network connectivity
ping -c 4 8.8.8.8
ping -c 4 google.com
nslookup google.com

# Check network interfaces
ifconfig
networksetup -listallhardwareports

# Test Wi-Fi
networksetup -getairportnetwork en0
```

### **4. Audio and Video**
```bash
# Test audio output
say "Audio test successful"

# Check audio devices
system_profiler SPAudioDataType

# Test video output
system_profiler SPDisplaysDataType
```

---

## 📱 **Application Testing**

### **1. Core Applications**
```bash
# Test Finder
open /Applications/Finder.app
# Verify: Can navigate, create folders, copy files

# Test Safari
open -a Safari
# Verify: Can browse web, bookmarks work, extensions load

# Test Mail
open -a Mail
# Verify: Can send/receive emails, accounts configured

# Test Calendar
open -a Calendar
# Verify: Can create events, sync with iCloud
```

### **2. Development Tools**
```bash
# Test Terminal
open -a Terminal
# Verify: Can run commands, shell configured

# Test VS Code
code --version
code --list-extensions
# Verify: Extensions loaded, settings applied

# Test Git
git --version
git config --list
# Verify: Git configured, SSH keys working

# Test Node.js
node --version
npm --version
# Verify: Node.js working, packages installable
```

### **3. Productivity Apps**
```bash
# Test 1Password
open -a "1Password 7"
# Verify: Can unlock, access passwords, sync working

# Test Alfred
open -a Alfred\ 5
# Verify: Can search, workflows working, preferences loaded

# Test Rectangle
open -a Rectangle
# Verify: Window management working, shortcuts active
```

---

## 🛠️ **Development Environment Testing**

### **1. Version Control**
```bash
# Test Git functionality
git init test-repo
cd test-repo
echo "test" > test.txt
git add test.txt
git commit -m "test commit"
git log --oneline
cd .. && rm -rf test-repo

# Test SSH keys
ssh -T git@github.com
ssh -T git@gitlab.com
```

### **2. Programming Languages**
```bash
# Test Python
python3 --version
python3 -c "print('Python test successful')"
pip3 --version

# Test Node.js
node --version
npm --version
node -e "console.log('Node.js test successful')"

# Test Go (if installed)
go version
go run -c "package main; import \"fmt\"; func main() { fmt.Println(\"Go test successful\") }"
```

### **3. Database Tools**
```bash
# Test PostgreSQL
psql --version
pg_ctl status

# Test Redis
redis-cli --version
redis-cli ping

# Test MongoDB (if installed)
mongod --version
mongo --version
```

### **4. Container Tools**
```bash
# Test Docker
docker --version
docker-compose --version
docker run hello-world

# Test Colima
colima version
colima status
```

---

## ⚡ **Performance Testing**

### **1. CPU Performance**
```bash
# CPU benchmark
sysbench cpu --threads=8 run

# Monitor CPU usage
top -l 1 | grep "CPU usage"
iostat -c 1 5
```

### **2. Memory Performance**
```bash
# Memory benchmark
sysbench memory --threads=8 run

# Monitor memory usage
vm_stat
memory_pressure
htop
```

### **3. Storage Performance**
```bash
# Disk benchmark
sudo dd if=/dev/zero of=/tmp/test bs=1m count=1024
sudo dd if=/tmp/test of=/dev/null bs=1m
rm /tmp/test

# Monitor disk usage
df -h
iostat -d 1 5
```

### **4. Network Performance**
```bash
# Network speed test
curl -o /dev/null -s -w "Download: %{speed_download} bytes/sec\n" http://speedtest.wdc01.softlayer.com/downloads/test100.zip

# Latency test
ping -c 10 8.8.8.8 | tail -1
```

---

## 🔒 **Security Testing**

### **1. FileVault Encryption**
```bash
# Check FileVault status
sudo fdesetup status
diskutil info / | grep "Encrypted"
```

### **2. Firewall Testing**
```bash
# Check firewall status
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode
```

### **3. Keychain Testing**
```bash
# Test keychain access
security find-generic-password -s "test" -w
security list-keychains
security default-keychain
```

### **4. App Permissions**
```bash
# Check app permissions
tccutil reset All
# Test: Camera, Microphone, Location, Contacts, etc.
```

---

## 🌐 **Integration Testing**

### **1. iCloud Sync Testing**
```bash
# Test iCloud sync
ls ~/iCloud\ Drive/
ls ~/Desktop/
ls ~/Documents/

# Verify sync status
brctl status
```

### **2. Backup Verification**
```bash
# Test backup access
ls ~/iCloud\ Drive/iCloud-Backup-20251022/
ls /Volumes/ssd_500gb/macbook-pro-backup-20251022/

# Verify backup integrity
md5sum ~/iCloud\ Drive/iCloud-Backup-20251022/BACKUP-SUMMARY.txt
```

### **3. Network Storage Testing**
```bash
# Test network storage access
ls /Volumes/data/
ls /Volumes/media/
ls /Volumes/ssd_500gb/

# Test read/write permissions
touch /Volumes/ssd_500gb/test-write.txt
rm /Volumes/ssd_500gb/test-write.txt
```

---

## 🧪 **Automated Testing Scripts**

### **1. System Health Check**
```bash
#!/bin/bash
# System health check script

echo "🧪 Running system health check..."

# Check system information
echo "📊 System Information:"
system_profiler SPHardwareDataType | grep -E "(Model|Chip|Memory|Storage)"

# Check network connectivity
echo "🌐 Network Test:"
ping -c 3 8.8.8.8 > /dev/null && echo "✅ Internet connection working" || echo "❌ Internet connection failed"

# Check disk space
echo "💾 Disk Space:"
df -h / | tail -1

# Check memory usage
echo "🧠 Memory Usage:"
vm_stat | grep -E "(free|active|inactive|wired)"

# Check running processes
echo "⚙️ Running Processes:"
ps aux | grep -v grep | wc -l | xargs echo "Process count:"

echo "✅ System health check complete!"
```

### **2. Application Testing Script**
```bash
#!/bin/bash
# Application testing script

echo "🧪 Testing applications..."

# Test core apps
apps=("Finder" "Safari" "Mail" "Calendar" "Terminal")
for app in "${apps[@]}"; do
    if open -a "$app" > /dev/null 2>&1; then
        echo "✅ $app launched successfully"
    else
        echo "❌ $app failed to launch"
    fi
done

# Test development tools
dev_tools=("code" "git" "node" "python3" "docker")
for tool in "${dev_tools[@]}"; do
    if command -v "$tool" > /dev/null 2>&1; then
        echo "✅ $tool is available"
    else
        echo "❌ $tool is not available"
    fi
done

echo "✅ Application testing complete!"
```

### **3. Performance Benchmark Script**
```bash
#!/bin/bash
# Performance benchmark script

echo "⚡ Running performance benchmarks..."

# CPU benchmark
echo "🖥️ CPU Performance:"
time sysbench cpu --threads=8 run > /dev/null 2>&1

# Memory benchmark
echo "🧠 Memory Performance:"
time sysbench memory --threads=8 run > /dev/null 2>&1

# Disk benchmark
echo "💾 Disk Performance:"
time sudo dd if=/dev/zero of=/tmp/test bs=1m count=100 > /dev/null 2>&1
time sudo dd if=/tmp/test of=/dev/null bs=1m > /dev/null 2>&1
rm /tmp/test

echo "✅ Performance benchmarks complete!"
```

---

## 📋 **Testing Checklist**

### **System Testing:**
- [ ] Hardware information verified
- [ ] macOS version confirmed
- [ ] System integrity checked
- [ ] Network connectivity tested
- [ ] Audio/video output working

### **Application Testing:**
- [ ] Core apps launching
- [ ] Development tools working
- [ ] Productivity apps functional
- [ ] Settings and preferences loaded
- [ ] Extensions and plugins working

### **Development Testing:**
- [ ] Version control working
- [ ] Programming languages functional
- [ ] Database tools operational
- [ ] Container tools working
- [ ] IDE and editors functional

### **Performance Testing:**
- [ ] CPU performance benchmarked
- [ ] Memory performance tested
- [ ] Storage performance verified
- [ ] Network performance checked
- [ ] Thermal management working

### **Security Testing:**
- [ ] FileVault encryption enabled
- [ ] Firewall configured
- [ ] Keychain accessible
- [ ] App permissions set
- [ ] Security tools functional

### **Integration Testing:**
- [ ] iCloud sync working
- [ ] Backup accessible
- [ ] Network storage functional
- [ ] Cross-app workflows working
- [ ] Data integrity verified

---

## 🚨 **Troubleshooting Common Issues**

### **1. App Launch Issues**
```bash
# Reset app permissions
sudo tccutil reset All

# Clear app caches
rm -rf ~/Library/Caches/*
sudo rm -rf /Library/Caches/*

# Reinstall problematic apps
brew reinstall --cask [app-name]
```

### **2. Performance Issues**
```bash
# Clear memory
sudo purge
sudo dscacheutil -flushcache

# Restart services
sudo launchctl kickstart -k system/com.apple.mDNSResponder
sudo launchctl kickstart -k system/com.apple.networkd

# Check for resource-intensive processes
top -l 1 | head -20
```

### **3. Network Issues**
```bash
# Reset network settings
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Reset network interfaces
sudo ifconfig en0 down
sudo ifconfig en0 up

# Check network configuration
networksetup -listallhardwareports
```

### **4. Storage Issues**
```bash
# Clear storage
sudo rm -rf /Library/Caches/*
sudo rm -rf ~/Library/Caches/*

# Optimize storage
sudo tmutil thinlocalsnapshots / 1000000000 1
sudo periodic daily weekly monthly

# Check disk health
diskutil info / | grep -E "(Solid State|S.M.A.R.T)"
```

---

## 📊 **Testing Reports**

### **1. Generate Test Report**
```bash
#!/bin/bash
# Generate comprehensive test report

echo "📊 Generating test report..."

# Create report file
report_file="~/Desktop/macbook-air-test-report-$(date +%Y%m%d).txt"

# System information
echo "=== SYSTEM INFORMATION ===" > "$report_file"
system_profiler SPHardwareDataType >> "$report_file"
echo "" >> "$report_file"

# Network test
echo "=== NETWORK TEST ===" >> "$report_file"
ping -c 3 8.8.8.8 >> "$report_file"
echo "" >> "$report_file"

# Disk space
echo "=== DISK SPACE ===" >> "$report_file"
df -h >> "$report_file"
echo "" >> "$report_file"

# Memory usage
echo "=== MEMORY USAGE ===" >> "$report_file"
vm_stat >> "$report_file"
echo "" >> "$report_file"

# Running processes
echo "=== RUNNING PROCESSES ===" >> "$report_file"
ps aux | head -20 >> "$report_file"

echo "✅ Test report generated: $report_file"
```

### **2. Performance Metrics**
```bash
#!/bin/bash
# Collect performance metrics

echo "📈 Collecting performance metrics..."

# CPU usage
echo "CPU Usage:"
top -l 1 | grep "CPU usage"

# Memory usage
echo "Memory Usage:"
vm_stat | grep -E "(free|active|inactive|wired)"

# Disk usage
echo "Disk Usage:"
df -h / | tail -1

# Network speed
echo "Network Speed:"
curl -o /dev/null -s -w "Download: %{speed_download} bytes/sec\n" http://speedtest.wdc01.softlayer.com/downloads/test100.zip
```

---

## 🎯 **Testing Recommendations**

### **Daily Testing:**
- Check system performance
- Verify app functionality
- Test network connectivity
- Monitor storage usage

### **Weekly Testing:**
- Run performance benchmarks
- Test backup integrity
- Verify security settings
- Check for updates

### **Monthly Testing:**
- Complete system health check
- Test all applications
- Verify integration workflows
- Review performance metrics

---

## 🚀 **Quick Testing Scripts**

### **Essential Testing (5 minutes):**
```bash
#!/bin/bash
# Essential testing

echo "🧪 Running essential tests..."

# System check
system_profiler SPHardwareDataType | grep -E "(Model|Chip|Memory)"

# Network test
ping -c 3 8.8.8.8 > /dev/null && echo "✅ Network OK" || echo "❌ Network Failed"

# App test
open -a Terminal > /dev/null 2>&1 && echo "✅ Terminal OK" || echo "❌ Terminal Failed"

echo "✅ Essential testing complete!"
```

### **Complete Testing (30 minutes):**
```bash
#!/bin/bash
# Complete testing

echo "🧪 Running complete tests..."

# System testing
echo "Testing system..."
system_profiler SPHardwareDataType
ping -c 3 8.8.8.8

# Application testing
echo "Testing applications..."
apps=("Finder" "Safari" "Mail" "Terminal" "VS Code")
for app in "${apps[@]}"; do
    open -a "$app" > /dev/null 2>&1 && echo "✅ $app OK" || echo "❌ $app Failed"
done

# Development testing
echo "Testing development tools..."
git --version
node --version
python3 --version

# Performance testing
echo "Testing performance..."
vm_stat
df -h

echo "✅ Complete testing finished!"
```

---

**Your MacBook Air setup is now thoroughly tested and validated! 🧪✅**