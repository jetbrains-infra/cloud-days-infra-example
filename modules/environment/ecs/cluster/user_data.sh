#!/bin/sh

yum install aws-cli -y

cat <<EOF > /usr/local/bin/heap-dump-uploader.sh
#!/bin/bash

/bin/aws s3 sync /tmp s3://${bucket}/dumps/$(date +%Y-%m-%d)/$(curl -sq http://169.254.169.254/latest/meta-data/instance-id)/ --exclude "*" --include "*.hprof" && rm -f /tmp/*.hprof

EOF

chmod 755 /usr/local/bin/heap-dump-uploader.sh

cat <<EOF > /etc/systemd/system/heap-dump-uploader.timer

[Unit]
Description=Run heap dump uploader each 3 minutes and on boot
Requires=heap-dump-uploader.service

[Timer]
OnBootSec=3min
OnUnitActiveSec=3min

[Install]
WantedBy=timers.target

EOF

cat <<EOF > /etc/systemd/system/heap-dump-uploader.service
[Unit]
Description=Collect heap dump and upload them to S3
Wants=heap-dump-uploader.timer

[Service]
Type=oneshot
ExecStart=/usr/local/bin/heap-dump-uploader.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl enable heap-dump-uploader.service
systemctl enable heap-dump-uploader.timer
systemctl start heap-dump-uploader.timer