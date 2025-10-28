#!/bin/bash
# macOS System Optimization for MacBook Air M1
# Focus on memory management and performance

echo "🔧 Optimizing macOS for vibe coding..."

# Memory management optimizations
echo "📊 Applying memory management optimizations..."

# Disable unnecessary animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
defaults write NSGlobalDomain NSRequiresAquaSystemAppearance -bool false

# Reduce transparency effects
defaults write com.apple.universalaccess reduceTransparency -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Optimize Finder
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder ShowPathbar -bool false
defaults write com.apple.finder ShowStatusBar -bool false

# Disable Spotlight indexing for development directories
echo "Disabling Spotlight indexing for development directories..."
sudo mdutil -i off /Users/daddy.dev.id/Workspace
sudo mdutil -i off /Users/daddy.dev.id/projects

# Optimize Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock static-only -bool true

# Disable unnecessary services
echo "Disabling unnecessary services..."
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist 2>/dev/null || true
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist 2>/dev/null || true

# Optimize power management
echo "Optimizing power management..."
sudo pmset -a standby 0
sudo pmset -a hibernatemode 0
sudo pmset -a autopoweroff 0
sudo pmset -a powernap 0
sudo pmset -a disksleep 0

# Set up swap optimization
echo "Configuring swap optimization..."
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf

# Create memory monitoring script
cat > ~/bin/memory-monitor.sh << 'EOF'
#!/bin/bash
# Memory monitoring script for MacBook Air M1
echo "📊 Memory Status:"
vm_stat | head -10
echo ""
echo "🔥 Top Memory Consumers:"
ps aux | sort -nr -k 4 | head -10
echo ""
echo "💾 Available Memory:"
free -h 2>/dev/null || echo "Use 'vm_stat' for detailed memory info"
EOF

chmod +x ~/bin/memory-monitor.sh

# Create performance monitoring script
cat > ~/bin/performance-check.sh << 'EOF'
#!/bin/bash
# Performance check script
echo "🚀 MacBook Air M1 Performance Check"
echo "=================================="
echo "CPU Usage:"
top -l 1 | grep "CPU usage"
echo ""
echo "Memory Usage:"
vm_stat | head -5
echo ""
echo "Load Average:"
uptime
echo ""
echo "Active Processes:"
ps aux | wc -l | xargs echo "Total processes:"
EOF

chmod +x ~/bin/performance-check.sh

echo "✅ macOS optimization complete!"
echo ""
echo "📋 Optimization Summary:"
echo "- Disabled unnecessary animations and transparency"
echo "- Optimized Finder and Dock"
echo "- Disabled Spotlight indexing for dev directories"
echo "- Configured power management for performance"
echo "- Set up swap optimization"
echo "- Created memory and performance monitoring scripts"
echo ""
echo "🔄 Please restart your MacBook Air to apply all optimizations"