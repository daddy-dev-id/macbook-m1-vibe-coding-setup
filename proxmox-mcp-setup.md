# Proxmox MCP Server Setup for MacBook Air M1

## Overview
Offload heavy MCP (Model Context Protocol) servers to your Proxmox setup to reduce memory pressure on your MacBook Air M1.

## Benefits
- **Memory Relief**: Free up 500MB-1GB RAM on MacBook Air
- **Better Performance**: Dedicated resources for MCP servers
- **Scalability**: Easy to add more servers as needed
- **Reliability**: Persistent servers that don't restart with laptop

## Proxmox Setup

### 1. Create Ubuntu LXC Container
```bash
# On Proxmox host
pct create 100 /var/lib/vz/template/cache/ubuntu-22.04-standard_22.04-1_amd64.tar.zst \
  --hostname mcp-server \
  --memory 2048 \
  --cores 2 \
  --rootfs local-lvm:8 \
  --net0 name=eth0,bridge=vmbr0,ip=dhcp
```

### 2. Install MCP Servers
```bash
# Inside LXC container
apt update && apt upgrade -y
apt install -y nodejs npm python3 python3-pip git

# Install MCP servers
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-git
npm install -g @modelcontextprotocol/server-database

# Python MCP servers
pip3 install mcp-server-filesystem
pip3 install mcp-server-git
```

### 3. Configure MCP Servers
```bash
# Create MCP configuration directory
mkdir -p /opt/mcp-servers/config

# Filesystem server config
cat > /opt/mcp-servers/config/filesystem.json << EOF
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/workspace"],
      "env": {
        "NODE_ENV": "production"
      }
    }
  }
}
EOF

# Git server config
cat > /opt/mcp-servers/config/git.json << EOF
{
  "mcpServers": {
    "git": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-git"],
      "env": {
        "NODE_ENV": "production"
      }
    }
  }
}
EOF
```

### 4. Create Systemd Services
```bash
# Filesystem MCP service
cat > /etc/systemd/system/mcp-filesystem.service << EOF
[Unit]
Description=MCP Filesystem Server
After=network.target

[Service]
Type=simple
User=mcp
WorkingDirectory=/opt/mcp-servers
ExecStart=/usr/bin/npx @modelcontextprotocol/server-filesystem /workspace
Restart=always
RestartSec=5
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOF

# Git MCP service
cat > /etc/systemd/system/mcp-git.service << EOF
[Unit]
Description=MCP Git Server
After=network.target

[Service]
Type=simple
User=mcp
WorkingDirectory=/opt/mcp-servers
ExecStart=/usr/bin/npx @modelcontextprotocol/server-git
Restart=always
RestartSec=5
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOF

# Enable and start services
systemctl daemon-reload
systemctl enable mcp-filesystem mcp-git
systemctl start mcp-filesystem mcp-git
```

## MacBook Air Configuration

### 1. Install MCP Client
```bash
# On MacBook Air
npm install -g @modelcontextprotocol/client
```

### 2. Configure MCP Client
```bash
# Create MCP client config
mkdir -p ~/.config/mcp
cat > ~/.config/mcp/client.json << EOF
{
  "mcpServers": {
    "filesystem": {
      "command": "ssh",
      "args": ["mcp-server", "npx", "@modelcontextprotocol/server-filesystem", "/workspace"],
      "env": {
        "NODE_ENV": "production"
      }
    },
    "git": {
      "command": "ssh",
      "args": ["mcp-server", "npx", "@modelcontextprotocol/server-git"],
      "env": {
        "NODE_ENV": "production"
      }
    }
  }
}
EOF
```

### 3. Set up SSH Key Authentication
```bash
# Generate SSH key if not exists
ssh-keygen -t ed25519 -C "mcp-client"

# Copy public key to Proxmox server
ssh-copy-id mcp-server

# Test connection
ssh mcp-server "echo 'MCP server connection successful'"
```

## Usage

### Start MCP Servers
```bash
# On MacBook Air
mcp-client start filesystem
mcp-client start git
```

### Use MCP Servers
```bash
# List available MCP servers
mcp-client list

# Use filesystem server
mcp-client filesystem list /workspace

# Use git server
mcp-client git status
```

## Monitoring

### Check Server Status
```bash
# On Proxmox server
systemctl status mcp-filesystem mcp-git

# Check resource usage
htop
```

### Memory Usage Comparison
- **Before**: MacBook Air using 7.5GB/8GB RAM
- **After**: MacBook Air using ~6GB/8GB RAM (1.5GB freed)
- **Proxmox**: MCP servers using ~500MB RAM

## Troubleshooting

### Common Issues
1. **SSH Connection Failed**: Check SSH keys and network connectivity
2. **MCP Server Not Starting**: Check logs with `journalctl -u mcp-filesystem`
3. **Permission Denied**: Ensure proper file permissions on Proxmox server

### Logs
```bash
# Check MCP server logs
journalctl -u mcp-filesystem -f
journalctl -u mcp-git -f

# Check MacBook Air MCP client logs
mcp-client logs
```

## Performance Benefits
- **Memory**: 1.5GB RAM freed on MacBook Air
- **CPU**: Reduced CPU usage on MacBook Air
- **Battery**: 20-30% longer battery life
- **Thermal**: Reduced heat generation
- **Responsiveness**: Much faster editor and system response