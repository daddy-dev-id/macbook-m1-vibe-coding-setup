#!/bin/bash

# 🎵 Start Vibe Coding Session
# Launches the complete vibe coding environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$PROJECT_ROOT/.env"

# Load environment variables
if [[ -f "$ENV_FILE" ]]; then
    source "$ENV_FILE"
else
    echo -e "${YELLOW}⚠️  No .env file found. Using defaults.${NC}"
fi

# Default values
M1_OPTIMIZED="${M1_OPTIMIZED:-true}"
CONDA_ENV_PATH="${CONDA_ENV_PATH:-/Volumes/LLM/miniconda3/envs/vibe-coding}"
EDITOR="${EDITOR:-code}"
BROWSER="${BROWSER:-chrome}"

print_header() {
    echo -e "${PURPLE}"
    echo "🎵 ================================================"
    echo "   MacBook M1 Vibe Coding Setup"
    echo "   Starting your productive development session"
    echo "================================================ 🎵"
    echo -e "${NC}"
}

check_prerequisites() {
    echo -e "${BLUE}🔍 Checking prerequisites...${NC}"
    
    # Check if running on M1
    if [[ "$(uname -m)" == "arm64" ]]; then
        echo -e "${GREEN}✅ Running on Apple Silicon (M1/M2)${NC}"
    else
        echo -e "${YELLOW}⚠️  Not running on Apple Silicon${NC}"
    fi
    
    # Check external storage
    if [[ -d "/Volumes/LLM" ]]; then
        echo -e "${GREEN}✅ LLM disk available${NC}"
    else
        echo -e "${YELLOW}⚠️  LLM disk not found${NC}"
    fi
    
    # Check conda environment
    if [[ -d "$CONDA_ENV_PATH" ]]; then
        echo -e "${GREEN}✅ Conda environment available${NC}"
    else
        echo -e "${YELLOW}⚠️  Conda environment not found${NC}"
        echo -e "${CYAN}💡 Run: ./scripts/setup-ml-environment.sh${NC}"
    fi
}

start_development_tools() {
    echo -e "${BLUE}🛠️  Starting development tools...${NC}"
    
    # Start VS Code if available
    if command -v code &> /dev/null; then
        echo -e "${GREEN}✅ Starting VS Code...${NC}"
        code "$PROJECT_ROOT" &
    fi
    
    # Start Cursor if available
    if command -v cursor &> /dev/null; then
        echo -e "${GREEN}✅ Starting Cursor...${NC}"
        cursor "$PROJECT_ROOT" &
    fi
    
    # Start Jupyter Lab if available
    if command -v jupyter &> /dev/null; then
        echo -e "${GREEN}✅ Starting Jupyter Lab...${NC}"
        cd "$PROJECT_ROOT"
        jupyter lab --no-browser --port=8888 &
        echo -e "${CYAN}📊 Jupyter Lab: http://localhost:8888${NC}"
    fi
}

show_daily_plan() {
    echo -e "${BLUE}📅 Daily Vibe Coding Plan${NC}"
    echo "----------------------------------------"
    echo -e "${YELLOW}🌅 Morning (30 min):${NC}"
    echo "  • Environment check"
    echo "  • Goal setting"
    echo "  • Task review"
    echo ""
    echo -e "${YELLOW}🎯 Deep Work (2-3 hours):${NC}"
    echo "  • Core development (90 min)"
    echo "  • Learning & research (60 min)"
    echo "  • Experimentation (60 min)"
    echo ""
    echo -e "${YELLOW}🌆 Evening (30 min):${NC}"
    echo "  • Progress review"
    echo "  • Environment cleanup"
    echo "  • Next day preparation"
    echo ""
}

show_quick_commands() {
    echo -e "${BLUE}⚡ Quick Commands${NC}"
    echo "----------------------------------------"
    echo -e "${CYAN}Task Management:${NC}"
    echo "  ./scripts/task-master.sh daily     # Daily planning"
    echo "  ./scripts/task-master.sh list      # List tasks"
    echo "  ./scripts/task-master.sh create    # Create task"
    echo ""
    echo -e "${CYAN}System Monitoring:${NC}"
    echo "  ./monitoring/check-m1-performance.sh  # Check performance"
    echo "  ./monitoring/cleanup-cache.sh         # Clean up system"
    echo ""
    echo -e "${CYAN}Environment:${NC}"
    echo "  ./scripts/optimize-macbook-m1.sh      # Optimize M1"
    echo "  ./scripts/setup-ml-environment.sh     # Setup ML env"
    echo ""
}

show_vibe_coding_tips() {
    echo -e "${BLUE}🎵 Vibe Coding Tips${NC}"
    echo "----------------------------------------"
    echo -e "${GREEN}✅ Flow State:${NC}"
    echo "  • Eliminate distractions"
    echo "  • Single focus, one task at a time"
    echo "  • Take breaks every 90 minutes"
    echo ""
    echo -e "${GREEN}✅ Sustainable Pace:${NC}"
    echo "  • Quality over speed"
    echo "  • Listen to your body"
    echo "  • Celebrate small wins"
    echo ""
    echo -e "${GREEN}✅ Continuous Learning:${NC}"
    echo "  • Daily learning (1 hour minimum)"
    echo "  • Document everything"
    echo "  • Stay curious and ask questions"
    echo ""
}

main() {
    print_header
    
    check_prerequisites
    
    echo ""
    start_development_tools
    
    echo ""
    show_daily_plan
    
    echo ""
    show_quick_commands
    
    echo ""
    show_vibe_coding_tips
    
    echo -e "${PURPLE}🎯 Ready to start vibe coding!${NC}"
    echo -e "${CYAN}💡 Run: ./scripts/task-master.sh daily${NC}"
    echo ""
}

# Run main function
main "$@"