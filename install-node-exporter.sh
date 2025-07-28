#!/bin/bash
echo "[*] Installing Node Exporter..."

# Create user
useradd -rs /bin/false node_exporter

# Download and install
cd /opt
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar xvf node_exporter-1.7.0.linux-amd64.tar.gz
mv node_exporter-1.7.0.linux-amd64/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Setup service
cp /home/ec2-user/your-repo-name/monitoring/node-exporter-init.dservice /etc/systemd/system/node_exporter.service

systemctl daemon-reexec
systemctl enable node_exporter
systemctl start node_exporter
