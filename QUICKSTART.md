# Quick Start Guide

## After System Restart

1. **Start Services**
   ```bash
   cd /Users/gd/CascadeProjects/ethical-hacking-lab
   docker-compose up -d
   ```

2. **Access Dashboards**
   - Grafana: http://localhost:3001
     - Username: admin
     - Password: admin

3. **Check Status**
   ```bash
   docker-compose ps
   ```

4. **View Logs**
   ```bash
   docker-compose logs -f
   ```

## Repository Access

1. **GitHub**
   - URL: https://github.com/GDEUHI/security-monitoring-lab
   - Clone: `git clone git@github.com:GDEUHI/security-monitoring-lab.git`

2. **GitLab**
   - URL: https://gitlab.com/kingdomofanderlecht/kastelofanderlecht
   - Clone: `git clone git@gitlab.com:kingdomofanderlecht/kastelofanderlecht.git`

## Common Commands

1. **Push Changes**
   ```bash
   git push origin main   # Push to GitHub
   git push gitlab main   # Push to GitLab
   ```

2. **Pull Changes**
   ```bash
   git pull origin main   # Pull from GitHub
   ```

3. **Stop Services**
   ```bash
   docker-compose down
   ```

4. **Restart Services**
   ```bash
   docker-compose restart
   ```

## Troubleshooting

1. **If SSH Key Issues**:
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

2. **Test Connections**:
   ```bash
   ssh -T git@github.com    # Test GitHub
   ssh -T git@gitlab.com    # Test GitLab
   ```

3. **Check Docker Status**:
   ```bash
   docker ps
   docker-compose ps
   ```

4. **View Service Logs**:
   ```bash
   docker-compose logs grafana
   docker-compose logs prometheus
   docker-compose logs elasticsearch
   ```
