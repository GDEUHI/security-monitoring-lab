# Grafana Plugins Guide

## Accessing the Marketplace

1. **Access Grafana**
   - Go to `http://localhost:3001`
   - Login with admin/admin

2. **Open Marketplace**
   - Click on the menu icon (☰) in the left sidebar
   - Click on "Administration"
   - Select "Plugins"

3. **Browse Plugins**
   - Use the search bar to find specific plugins
   - Filter by categories: Panels, Data Sources, Apps
   - Click on any plugin to see details and installation instructions

## Pre-installed Plugins

We've already configured these plugins in docker-compose.yml:

### Visualization Panels
- grafana-piechart-panel: Pie and donut charts
- grafana-worldmap-panel: Geographical data visualization
- grafana-clock-panel: Time display
- grafana-polystat-panel: Hexagon metrics display
- grafana-sankey-panel: Flow visualization
- grafana-threatmap-panel: Security threat visualization
- grafana-statusmap: Status heatmaps
- grafana-network-panel: Network topology

### Data Sources
- grafana-elasticsearch-datasource
- grafana-prometheus-datasource
- grafana-loki-datasource
- grafana-influxdb-datasource

### Utilities
- grafana-image-renderer: Screenshot and PDF export
- grafana-webhook-notifier: External notifications

## Installing New Plugins

### Method 1: Docker-Compose (Recommended)
1. Add plugin to `GF_INSTALL_PLUGINS` in docker-compose.yml
2. Restart Grafana container:
   ```bash
   docker-compose restart grafana
   ```

### Method 2: Grafana UI
1. Find plugin in Marketplace
2. Click "Install"
3. Restart Grafana when prompted

### Method 3: Manual Installation
1. Use grafana-cli inside container:
   ```bash
   docker-compose exec grafana grafana-cli plugins install <plugin-id>
   ```
2. Restart Grafana:
   ```bash
   docker-compose restart grafana
   ```

## Using Plugins

1. **Add Panel**
   - Edit dashboard
   - Click "Add panel"
   - Select "Visualization" to see installed panel plugins

2. **Configure Data Source**
   - Go to Configuration → Data Sources
   - Click "Add data source"
   - Select from installed data sources

3. **Enable Features**
   - Some plugins may need additional configuration
   - Check plugin documentation for specific settings

## Troubleshooting

1. **Plugin Not Appearing**
   - Check docker-compose logs:
     ```bash
     docker-compose logs grafana
     ```
   - Verify plugin is listed in installed plugins:
     ```bash
     docker-compose exec grafana grafana-cli plugins ls
     ```

2. **Plugin Errors**
   - Check browser console for errors
   - Verify plugin compatibility with Grafana version
   - Check plugin documentation for requirements

3. **Common Issues**
   - Permission problems: Check Grafana user permissions
   - Network issues: Verify container networking
   - Version mismatch: Update Grafana or plugin version
