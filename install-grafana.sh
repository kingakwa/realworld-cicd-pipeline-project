#!/bin/bash
echo "[*] Installing Grafana..."

cat <<EOF | tee /etc/yum.repos.d/grafana.repo
[grafana]
name=Grafana OSS
baseurl=https://rpm.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
EOF

yum install -y grafana
systemctl enable grafana-server
systemctl start grafana-server
