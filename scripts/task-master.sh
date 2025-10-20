#!/bin/bash

# 🎯 Task Master - Vibe Coding Task Management System
# Designed for senior engineers transitioning to AI/ML development

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
TASK_DIR="$HOME/.vibe-coding/tasks"
TEMPLATES_DIR="$HOME/.vibe-coding/templates"
CONFIG_FILE="$HOME/.vibe-coding/config"

# Create directories if they don't exist
mkdir -p "$TASK_DIR" "$TEMPLATES_DIR"

# Load configuration
load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    else
        # Default configuration
        export TASK_EDITOR="${EDITOR:-code}"
        export TASK_PRIORITY_LEVELS="low,medium,high,critical"
        export TASK_STATUS_LEVELS="pending,in_progress,blocked,completed,cancelled"
        export TASK_CATEGORIES="ai-ml,research,development,learning,optimization,deployment"
        export TASK_DAILY_LIMIT=5
        export TASK_WEEKLY_LIMIT=25
    fi
}

# Save configuration
save_config() {
    cat > "$CONFIG_FILE" << EOF
# Vibe Coding Task Master Configuration
export TASK_EDITOR="${TASK_EDITOR:-code}"
export TASK_PRIORITY_LEVELS="low,medium,high,critical"
export TASK_STATUS_LEVELS="pending,in_progress,blocked,completed,cancelled"
export TASK_CATEGORIES="ai-ml,research,development,learning,optimization,deployment"
export TASK_DAILY_LIMIT=5
export TASK_WEEKLY_LIMIT=25
EOF
}

# Initialize task master
init() {
    echo -e "${BLUE}🎯 Initializing Task Master...${NC}"
    
    # Create initial configuration
    save_config
    load_config
    
    # Create initial templates
    create_templates
    
    # Create sample tasks
    create_sample_tasks
    
    echo -e "${GREEN}✅ Task Master initialized successfully!${NC}"
    echo -e "${CYAN}📁 Task directory: $TASK_DIR${NC}"
    echo -e "${CYAN}📁 Templates directory: $TEMPLATES_DIR${NC}"
    echo -e "${CYAN}⚙️  Config file: $CONFIG_FILE${NC}"
}

# Create task templates
create_templates() {
    echo -e "${BLUE}📝 Creating task templates...${NC}"
    
    # AI/ML Research Template
    cat > "$TEMPLATES_DIR/ai-ml-research.md" << 'EOF'
# AI/ML Research Task

## 📋 Task Details
- **Title:** [Research Topic]
- **Category:** ai-ml
- **Priority:** medium
- **Status:** pending
- **Estimated Time:** 2-4 hours
- **Created:** $(date)

## 🎯 Objective
[Clear objective for the research]

## 📚 Resources
- [ ] Paper 1: [Title] - [URL]
- [ ] Paper 2: [Title] - [URL]
- [ ] Tutorial: [Title] - [URL]
- [ ] Documentation: [Framework] - [URL]

## 🔬 Research Questions
1. [Question 1]
2. [Question 2]
3. [Question 3]

## 📊 Expected Outcomes
- [ ] Understanding of [concept]
- [ ] Implementation notes
- [ ] Code examples
- [ ] Next steps

## 🚀 Action Items
- [ ] Read and analyze papers
- [ ] Implement basic examples
- [ ] Document findings
- [ ] Create summary

## 📝 Notes
[Research notes and insights]

## 🔗 Related Tasks
- [ ] [Related task 1]
- [ ] [Related task 2]
EOF

    # Development Task Template
    cat > "$TEMPLATES_DIR/development.md" << 'EOF'
# Development Task

## 📋 Task Details
- **Title:** [Feature/Bug Description]
- **Category:** development
- **Priority:** high
- **Status:** pending
- **Estimated Time:** 4-8 hours
- **Created:** $(date)

## 🎯 Objective
[Clear objective for the development task]

## 🛠️ Technical Requirements
- [ ] [Requirement 1]
- [ ] [Requirement 2]
- [ ] [Requirement 3]

## 📁 Files to Modify
- [ ] [File 1]
- [ ] [File 2]
- [ ] [File 3]

## 🧪 Testing Strategy
- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing
- [ ] Performance testing

## 🚀 Implementation Steps
1. [ ] [Step 1]
2. [ ] [Step 2]
3. [ ] [Step 3]
4. [ ] [Step 4]

## 📝 Notes
[Implementation notes and decisions]

## 🔗 Related Tasks
- [ ] [Related task 1]
- [ ] [Related task 2]
EOF

    # Learning Task Template
    cat > "$TEMPLATES_DIR/learning.md" << 'EOF'
# Learning Task

## 📋 Task Details
- **Title:** [Learning Topic]
- **Category:** learning
- **Priority:** medium
- **Status:** pending
- **Estimated Time:** 3-6 hours
- **Created:** $(date)

## 🎯 Learning Objective
[What you want to learn and why]

## 📚 Learning Resources
- [ ] Course: [Title] - [URL]
- [ ] Book: [Title] - [Author]
- [ ] Tutorial: [Title] - [URL]
- [ ] Documentation: [Framework] - [URL]

## 🎓 Learning Goals
- [ ] [Goal 1]
- [ ] [Goal 2]
- [ ] [Goal 3]

## 🛠️ Hands-on Practice
- [ ] [Practice exercise 1]
- [ ] [Practice exercise 2]
- [ ] [Practice exercise 3]

## 📊 Assessment
- [ ] [How will you know you've learned it?]
- [ ] [What will you build to demonstrate?]

## 📝 Notes
[Learning notes and insights]

## 🔗 Related Tasks
- [ ] [Related task 1]
- [ ] [Related task 2]
EOF

    echo -e "${GREEN}✅ Templates created successfully!${NC}"
}

# Create sample tasks
create_sample_tasks() {
    echo -e "${BLUE}📝 Creating sample tasks...${NC}"
    
    # Sample AI/ML Research Task
    cat > "$TASK_DIR/001-ai-ml-research.md" << 'EOF'
# AI/ML Research Task

## 📋 Task Details
- **Title:** Understanding Transformer Architecture
- **Category:** ai-ml
- **Priority:** high
- **Status:** pending
- **Estimated Time:** 4 hours
- **Created:** 2024-10-21

## 🎯 Objective
Deep dive into transformer architecture to understand the foundation of modern LLMs and build intuition for working with transformer-based models.

## 📚 Resources
- [ ] Paper: "Attention Is All You Need" - https://arxiv.org/abs/1706.03762
- [ ] Tutorial: "The Illustrated Transformer" - http://jalammar.github.io/illustrated-transformer/
- [ ] Video: "Transformer Neural Networks" - https://www.youtube.com/watch?v=XSSTJ4VXaKY
- [ ] Documentation: PyTorch Transformer - https://pytorch.org/docs/stable/nn.html#transformer

## 🔬 Research Questions
1. How does self-attention mechanism work?
2. What are the key components of transformer architecture?
3. How do transformers handle sequential data?
4. What are the advantages over RNNs/LSTMs?

## 📊 Expected Outcomes
- [ ] Understanding of attention mechanism
- [ ] Implementation of basic transformer components
- [ ] Code examples for self-attention
- [ ] Next steps for advanced transformer concepts

## 🚀 Action Items
- [ ] Read and analyze "Attention Is All You Need" paper
- [ ] Implement basic self-attention mechanism
- [ ] Build simple transformer encoder
- [ ] Document key insights and code

## 📝 Notes
[Research notes and insights will go here]

## 🔗 Related Tasks
- [ ] [Related task 1]
- [ ] [Related task 2]
EOF

    # Sample Development Task
    cat > "$TASK_DIR/002-development.md" << 'EOF'
# Development Task

## 📋 Task Details
- **Title:** Implement M1-Optimized ML Pipeline
- **Category:** development
- **Priority:** high
- **Status:** pending
- **Estimated Time:** 6 hours
- **Created:** 2024-10-21

## 🎯 Objective
Create an M1-optimized machine learning pipeline that leverages Apple Silicon's Neural Engine and unified memory architecture for efficient model training and inference.

## 🛠️ Technical Requirements
- [ ] PyTorch with M1 GPU support
- [ ] TensorFlow with Metal GPU acceleration
- [ ] Memory-efficient data loading
- [ ] M1-specific optimizations

## 📁 Files to Modify
- [ ] `scripts/setup-ml-environment.sh`
- [ ] `src/ml_pipeline.py`
- [ ] `config/m1_optimization.yaml`
- [ ] `tests/test_m1_pipeline.py`

## 🧪 Testing Strategy
- [ ] Unit tests for M1 optimizations
- [ ] Performance benchmarks
- [ ] Memory usage tests
- [ ] Cross-platform compatibility

## 🚀 Implementation Steps
1. [ ] Set up M1-optimized PyTorch environment
2. [ ] Implement memory-efficient data loader
3. [ ] Add M1-specific optimizations
4. [ ] Create performance monitoring
5. [ ] Write comprehensive tests

## 📝 Notes
[Implementation notes and decisions will go here]

## 🔗 Related Tasks
- [ ] [Related task 1]
- [ ] [Related task 2]
EOF

    echo -e "${GREEN}✅ Sample tasks created successfully!${NC}"
}

# Create a new task
create_task() {
    local title="$1"
    local category="${2:-development}"
    local priority="${3:-medium}"
    
    if [[ -z "$title" ]]; then
        echo -e "${RED}❌ Error: Task title is required${NC}"
        echo "Usage: $0 create \"Task Title\" [category] [priority]"
        return 1
    fi
    
    # Generate task ID
    local task_id=$(printf "%03d" $(($(ls -1 "$TASK_DIR"/*.md 2>/dev/null | wc -l) + 1)))
    local task_file="$TASK_DIR/${task_id}-${category}.md"
    
    # Get template
    local template_file="$TEMPLATES_DIR/${category}.md"
    if [[ ! -f "$template_file" ]]; then
        template_file="$TEMPLATES_DIR/development.md"
    fi
    
    # Create task from template
    cp "$template_file" "$task_file"
    
    # Replace placeholders
    sed -i.bak "s/\[Title\]/$title/g" "$task_file"
    sed -i.bak "s/\[Category\]/$category/g" "$task_file"
    sed -i.bak "s/\[Priority\]/$priority/g" "$task_file"
    sed -i.bak "s/\$(date)/$(date '+%Y-%m-%d')/g" "$task_file"
    
    # Clean up backup file
    rm -f "$task_file.bak"
    
    echo -e "${GREEN}✅ Task created: $task_file${NC}"
    echo -e "${CYAN}📝 Edit with: $TASK_EDITOR $task_file${NC}"
}

# List tasks
list_tasks() {
    local status="${1:-all}"
    local category="${2:-all}"
    
    echo -e "${BLUE}📋 Task List${NC}"
    echo -e "${CYAN}Status: $status | Category: $category${NC}"
    echo "----------------------------------------"
    
    for task_file in "$TASK_DIR"/*.md; do
        if [[ -f "$task_file" ]]; then
            local filename=$(basename "$task_file")
            local task_id=$(echo "$filename" | cut -d'-' -f1)
            local task_category=$(echo "$filename" | cut -d'-' -f2 | cut -d'.' -f1)
            
            # Extract task details
            local title=$(grep "^\*\*Title:\*\*" "$task_file" | sed 's/.*\*\*Title:\*\* //')
            local priority=$(grep "^\*\*Priority:\*\*" "$task_file" | sed 's/.*\*\*Priority:\*\* //')
            local status_val=$(grep "^\*\*Status:\*\*" "$task_file" | sed 's/.*\*\*Status:\*\* //')
            local created=$(grep "^\*\*Created:\*\*" "$task_file" | sed 's/.*\*\*Created:\*\* //')
            
            # Filter by status and category
            if [[ "$status" != "all" && "$status_val" != "$status" ]]; then
                continue
            fi
            if [[ "$category" != "all" && "$task_category" != "$category" ]]; then
                continue
            fi
            
            # Color code priority
            local priority_color=""
            case "$priority" in
                "critical") priority_color="$RED" ;;
                "high") priority_color="$YELLOW" ;;
                "medium") priority_color="$GREEN" ;;
                "low") priority_color="$CYAN" ;;
            esac
            
            echo -e "${priority_color}#$task_id${NC} | ${BLUE}$title${NC} | ${PURPLE}$task_category${NC} | ${priority_color}$priority${NC} | $status_val | $created"
        fi
    done
}

# Update task status
update_status() {
    local task_id="$1"
    local new_status="$2"
    
    if [[ -z "$task_id" || -z "$new_status" ]]; then
        echo -e "${RED}❌ Error: Task ID and status are required${NC}"
        echo "Usage: $0 status <task_id> <new_status>"
        return 1
    fi
    
    local task_file="$TASK_DIR/${task_id}-*.md"
    if [[ ! -f $task_file ]]; then
        echo -e "${RED}❌ Error: Task $task_id not found${NC}"
        return 1
    fi
    
    # Update status in file
    sed -i.bak "s/^\*\*Status:\*\* .*/**Status:** $new_status/" $task_file
    rm -f $task_file.bak
    
    echo -e "${GREEN}✅ Task $task_id status updated to: $new_status${NC}"
}

# Show task details
show_task() {
    local task_id="$1"
    
    if [[ -z "$task_id" ]]; then
        echo -e "${RED}❌ Error: Task ID is required${NC}"
        echo "Usage: $0 show <task_id>"
        return 1
    fi
    
    local task_file="$TASK_DIR/${task_id}-*.md"
    if [[ ! -f $task_file ]]; then
        echo -e "${RED}❌ Error: Task $task_id not found${NC}"
        return 1
    fi
    
    echo -e "${BLUE}📋 Task Details${NC}"
    echo "----------------------------------------"
    cat "$task_file"
}

# Daily task planning
daily_plan() {
    echo -e "${BLUE}📅 Daily Task Planning${NC}"
    echo -e "${CYAN}Date: $(date '+%Y-%m-%d')${NC}"
    echo "----------------------------------------"
    
    # Show pending tasks
    echo -e "${YELLOW}📋 Pending Tasks:${NC}"
    list_tasks "pending"
    
    echo ""
    echo -e "${GREEN}🎯 Today's Focus:${NC}"
    echo "1. [ ] [High priority task]"
    echo "2. [ ] [Medium priority task]"
    echo "3. [ ] [Learning task]"
    echo "4. [ ] [Development task]"
    echo "5. [ ] [Research task]"
    
    echo ""
    echo -e "${PURPLE}💡 Tips:${NC}"
    echo "- Focus on 1-2 high-priority tasks"
    echo "- Include at least one learning task"
    echo "- Take breaks every 90 minutes"
    echo "- Review progress at end of day"
}

# Weekly review
weekly_review() {
    echo -e "${BLUE}📊 Weekly Review${NC}"
    echo -e "${CYAN}Week of: $(date '+%Y-%m-%d')${NC}"
    echo "----------------------------------------"
    
    # Count tasks by status
    local completed=$(grep -r "^\*\*Status:\*\* completed" "$TASK_DIR" | wc -l)
    local in_progress=$(grep -r "^\*\*Status:\*\* in_progress" "$TASK_DIR" | wc -l)
    local pending=$(grep -r "^\*\*Status:\*\* pending" "$TASK_DIR" | wc -l)
    local blocked=$(grep -r "^\*\*Status:\*\* blocked" "$TASK_DIR" | wc -l)
    
    echo -e "${GREEN}✅ Completed: $completed${NC}"
    echo -e "${YELLOW}🔄 In Progress: $in_progress${NC}"
    echo -e "${BLUE}⏳ Pending: $pending${NC}"
    echo -e "${RED}🚫 Blocked: $blocked${NC}"
    
    echo ""
    echo -e "${PURPLE}📈 This Week's Achievements:${NC}"
    echo "- [List your key achievements]"
    
    echo ""
    echo -e "${PURPLE}🎯 Next Week's Goals:${NC}"
    echo "- [List your goals for next week]"
    
    echo ""
    echo -e "${PURPLE}💡 Insights:${NC}"
    echo "- [What worked well?]"
    echo "- [What could be improved?]"
    echo "- [What did you learn?]"
}

# Help
show_help() {
    echo -e "${BLUE}🎯 Task Master - Vibe Coding Task Management${NC}"
    echo ""
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  init                    Initialize Task Master"
    echo "  create <title> [cat] [pri]  Create new task"
    echo "  list [status] [category]    List tasks"
    echo "  show <task_id>             Show task details"
    echo "  status <task_id> <status>   Update task status"
    echo "  daily                     Show daily planning"
    echo "  weekly                    Show weekly review"
    echo "  help                      Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 init"
    echo "  $0 create \"Learn PyTorch\" ai-ml high"
    echo "  $0 list pending ai-ml"
    echo "  $0 show 001"
    echo "  $0 status 001 in_progress"
    echo "  $0 daily"
    echo "  $0 weekly"
    echo ""
    echo "Categories: ai-ml, research, development, learning, optimization, deployment"
    echo "Priorities: low, medium, high, critical"
    echo "Statuses: pending, in_progress, blocked, completed, cancelled"
}

# Main function
main() {
    load_config
    
    case "${1:-help}" in
        "init")
            init
            ;;
        "create")
            create_task "$2" "$3" "$4"
            ;;
        "list")
            list_tasks "$2" "$3"
            ;;
        "show")
            show_task "$2"
            ;;
        "status")
            update_status "$2" "$3"
            ;;
        "daily")
            daily_plan
            ;;
        "weekly")
            weekly_review
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

# Run main function
main "$@"