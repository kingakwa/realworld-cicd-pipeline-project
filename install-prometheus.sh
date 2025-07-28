#!/bin/bash
echo "[*] Installing Prometheus..."

cd /opt
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.51.0/prometheus-2.51.0.linux-amd64.tar.gz
tar xvf prometheus-2.51.0.linux-amd64.tar.gz
mv prometheus-2.51.0.linux-amd64 /etc/prometheus

useradd -rs /bin/false prometheus
chown -R prometheus:prometheus /etc/prometheus

cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
ExecStart=/etc/prometheus/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path="/etc/prometheus/data"

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl enable prometheus
systemctl start prometheus
