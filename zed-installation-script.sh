#!/bin/bash
# Zed Editor Optimization Installation Script
# MacBook Air M1 - Cursor Replacement Setup

echo "🚀 Installing Zed Editor Optimization for MacBook Air M1"
echo "========================================================"

# Check if Zed is installed
if ! command -v zed &> /dev/null; then
    echo "❌ Zed is not installed. Please install Zed first."
    echo "   Visit: https://zed.dev"
    exit 1
fi

echo "✅ Zed is installed: $(zed --version)"

# Create backup of current configuration
echo "📦 Creating backup of current configuration..."
if [ -f ~/.config/zed/settings.json ]; then
    cp ~/.config/zed/settings.json ~/.config/zed/settings.json.backup.$(date +%Y%m%d_%H%M%S)
    echo "✅ Backup created: ~/.config/zed/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
else
    echo "⚠️  No existing configuration found"
fi

# Install JetBrains Mono font
echo "🔤 Installing JetBrains Mono font..."
if command -v brew &> /dev/null; then
    brew install --cask font-jetbrains-mono
    echo "✅ JetBrains Mono font installed"
else
    echo "⚠️  Homebrew not found. Please install JetBrains Mono manually:"
    echo "   https://www.jetbrains.com/lp/mono/"
fi

# Install Fira Code as alternative
echo "🔤 Installing Fira Code font (alternative)..."
if command -v brew &> /dev/null; then
    brew install --cask font-fira-code
    echo "✅ Fira Code font installed"
else
    echo "⚠️  Homebrew not found. Please install Fira Code manually:"
    echo "   https://github.com/tonsky/FiraCode"
fi

# Apply optimized configuration
echo "⚙️  Applying optimized configuration..."
cat > ~/.config/zed/settings.json << 'EOF'
{
  "icon_theme": "Catppuccin Macchiato",
  "ui_font_family": "SF Pro Display",
  "ui_font_size": 17,
  "buffer_font_family": "JetBrains Mono",
  "buffer_font_size": 18,
  "buffer_font_weight": "Medium",
  "buffer_line_height": 1.5,
  "buffer_letter_spacing": 0.5,
  "theme": {
    "mode": "dark",
    "dark": "One Dark Pro"
  },
  "font_ligatures": true,
  "cursor": {
    "blink": true,
    "blink_interval": 1000,
    "width": 2
  },
  "selection": {
    "background": "#264f78",
    "foreground": "#ffffff"
  },
  "auto_save": "off",
  "auto_format_on_save": false,
  "vim_mode": false,
  "show_completions_on_input": false,
  "lsp": {
    "enable_inline_completions": false,
    "enable_snippets": false
  },
  "max_undo_history": 1000,
  "max_redo_history": 100,
  "max_search_history": 50,
  "git": {
    "show_status": false,
    "show_blame": false
  },
  "terminal": {
    "shell": {
      "program": "/bin/zsh",
      "args": ["-l"]
    },
    "font_size": 16,
    "scrollback_limit": 1000
  },
  "file_watcher": {
    "debounce_ms": 1000
  },
  "animations": false,
  "ui_animations": false
}
EOF

echo "✅ Optimized configuration applied"

# Create font testing script
echo "🧪 Creating font testing script..."
cat > ~/bin/test-zed-fonts.sh << 'EOF'
#!/bin/bash
# Test different fonts in Zed
echo "Testing Zed fonts..."
echo "==================="

echo "Available fonts:"
echo "1. JetBrains Mono (Recommended)"
echo "2. Fira Code"
echo "3. SF Mono (System)"
echo "4. Monaco (System)"
echo "5. Menlo (System)"

echo ""
echo "To test fonts, edit ~/.config/zed/settings.json and change:"
echo "  \"buffer_font_family\": \"Font Name Here\""
echo ""
echo "Then restart Zed to see the changes."
EOF

chmod +x ~/bin/test-zed-fonts.sh

# Create performance monitoring script
echo "📊 Creating performance monitoring script..."
cat > ~/bin/zed-performance.sh << 'EOF'
#!/bin/bash
# Monitor Zed performance
echo "Zed Performance Monitor"
echo "======================="

echo "Memory Usage:"
ps aux | grep -i zed | grep -v grep | awk '{print "  PID: " $2 ", Memory: " $4 "%, CPU: " $3 "%"}'

echo ""
echo "Process Count:"
ps aux | grep -i zed | grep -v grep | wc -l | xargs echo "  Active processes:"

echo ""
echo "System Memory:"
vm_stat | head -5
EOF

chmod +x ~/bin/zed-performance.sh

echo ""
echo "🎉 Zed Editor Optimization Complete!"
echo "===================================="
echo ""
echo "📋 What was configured:"
echo "✅ JetBrains Mono font (18px) for better readability"
echo "✅ SF Pro Display font (17px) for UI"
echo "✅ Dark theme with high contrast"
echo "✅ Font ligatures enabled"
echo "✅ Cursor and selection optimizations"
echo "✅ Accessibility improvements for glasses wearers"
echo "✅ Performance optimizations maintained"
echo ""
echo "🔧 Testing scripts created:"
echo "  ~/bin/test-zed-fonts.sh  - Test different fonts"
echo "  ~/bin/zed-performance.sh - Monitor performance"
echo ""
echo "🚀 Next steps:"
echo "1. Restart Zed to apply changes"
echo "2. Test font rendering on your displays"
echo "3. Adjust font size if needed (18px → 19-20px)"
echo "4. Test with Cursor CLI integration"
echo ""
echo "📖 Full documentation: zed-optimization-plan.md"