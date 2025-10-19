#!/bin/bash

# Cache Cleanup Script for MacBook M1 Vibe Coding Setup
# This script safely cleans up various caches to free up disk space

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Function to get cache size
get_cache_size() {
    if [ -d "$1" ]; then
        du -sh "$1" 2>/dev/null | cut -f1
    else
        echo "N/A"
    fi
}

# Function to clean UV cache
clean_uv_cache() {
    print_info "Cleaning UV Python package cache..."
    if command -v uv &> /dev/null; then
        local before_size=$(get_cache_size ~/.cache/uv)
        uv cache clean
        local after_size=$(get_cache_size ~/.cache/uv)
        print_status "UV cache cleaned: $before_size → $after_size"
    else
        print_warning "UV not found, skipping UV cache cleanup"
    fi
}

# Function to clean Hugging Face cache
clean_huggingface_cache() {
    print_info "Cleaning Hugging Face model cache..."
    local before_size=$(get_cache_size ~/.cache/huggingface)
    
    # Clean hub cache (downloaded models)
    if [ -d ~/.cache/huggingface/hub ]; then
        rm -rf ~/.cache/huggingface/hub/*
        print_status "Cleaned Hugging Face hub cache"
    fi
    
    # Clean xet cache (git-lfs cache)
    if [ -d ~/.cache/huggingface/xet ]; then
        rm -rf ~/.cache/huggingface/xet/*
        print_status "Cleaned Hugging Face xet cache"
    fi
    
    local after_size=$(get_cache_size ~/.cache/huggingface)
    print_status "Hugging Face cache cleaned: $before_size → $after_size"
}

# Function to clean Puppeteer cache
clean_puppeteer_cache() {
    print_info "Cleaning Puppeteer browser cache..."
    local before_size=$(get_cache_size ~/.cache/puppeteer)
    
    if [ -d ~/.cache/puppeteer ]; then
        rm -rf ~/.cache/puppeteer/*
        print_status "Cleaned Puppeteer cache"
    fi
    
    local after_size=$(get_cache_size ~/.cache/puppeteer)
    print_status "Puppeteer cache cleaned: $before_size → $after_size"
}

# Function to clean other development caches
clean_other_caches() {
    print_info "Cleaning other development caches..."
    
    # Outlines cache
    if [ -d ~/.cache/outlines ]; then
        local before_size=$(get_cache_size ~/.cache/outlines)
        rm -rf ~/.cache/outlines/*
        print_status "Cleaned Outlines cache ($before_size)"
    fi
    
    # Pre-commit cache
    if [ -d ~/.cache/pre-commit ]; then
        local before_size=$(get_cache_size ~/.cache/pre-commit)
        rm -rf ~/.cache/pre-commit/*
        print_status "Cleaned pre-commit cache ($before_size)"
    fi
    
    # Chrome DevTools MCP cache
    if [ -d ~/.cache/chrome-devtools-mcp ]; then
        local before_size=$(get_cache_size ~/.cache/chrome-devtools-mcp)
        rm -rf ~/.cache/chrome-devtools-mcp
        print_status "Cleaned Chrome DevTools MCP cache ($before_size)"
    fi
    
    # Prisma cache
    if [ -d ~/.cache/prisma ]; then
        local before_size=$(get_cache_size ~/.cache/prisma)
        rm -rf ~/.cache/prisma/*
        print_status "Cleaned Prisma cache ($before_size)"
    fi
}

# Function to clean system caches (optional)
clean_system_caches() {
    print_info "Cleaning system caches..."
    
    # Clear DNS cache
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    print_status "Cleared DNS cache"
    
    # Clear system log files (older than 7 days)
    sudo find /var/log -name "*.log" -mtime +7 -delete 2>/dev/null || true
    print_status "Cleared old system logs"
    
    # Clear user log files
    find ~/Library/Logs -name "*.log" -mtime +7 -delete 2>/dev/null || true
    print_status "Cleared old user logs"
}

# Function to show cache statistics
show_cache_stats() {
    print_header "Cache Statistics"
    
    echo -e "${BLUE}Current cache sizes:${NC}"
    echo "Total .cache directory: $(get_cache_size ~/.cache)"
    echo "UV cache: $(get_cache_size ~/.cache/uv)"
    echo "Hugging Face cache: $(get_cache_size ~/.cache/huggingface)"
    echo "Puppeteer cache: $(get_cache_size ~/.cache/puppeteer)"
    echo "Outlines cache: $(get_cache_size ~/.cache/outlines)"
    echo "Pre-commit cache: $(get_cache_size ~/.cache/pre-commit)"
    echo "Chrome DevTools MCP cache: $(get_cache_size ~/.cache/chrome-devtools-mcp)"
    echo "Prisma cache: $(get_cache_size ~/.cache/prisma)"
    echo ""
}

# Main function
main() {
    print_header "MacBook M1 Cache Cleanup Script"
    echo "This script will clean up various caches to free up disk space."
    echo ""
    
    # Show initial cache stats
    show_cache_stats
    
    # Ask for confirmation
    read -p "Do you want to proceed with cache cleanup? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Cache cleanup cancelled."
        exit 0
    fi
    
    print_header "Starting Cache Cleanup"
    
    # Clean various caches
    clean_uv_cache
    clean_huggingface_cache
    clean_puppeteer_cache
    clean_other_caches
    
    # Optional system cache cleanup
    read -p "Do you want to clean system caches as well? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        clean_system_caches
    fi
    
    print_header "Cache Cleanup Complete"
    
    # Show final cache stats
    show_cache_stats
    
    # Calculate space saved
    print_status "Cache cleanup completed successfully!"
    print_info "You can run this script again anytime to clean up caches."
}

# Run main function
main "$@"