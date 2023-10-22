# create user/group to run web app
sudo adduser --system --no-create-home webrunner
sudo addgroup --system webrunner
sudo usermod -g nobody webrunner

# create file in /etc/systemd/system/http_server.service

```file
[Unit]
Description=My Server
After=network.target

[Service]
User=nobody
Group=root
ExecStart=/apps/go/bin/http_server
Restart=always
RestartSec=5
StandardOutput=append:/var/log/http_server.log
StandardError=append:/var/log/http_server.log

[Install]
WantedBy=multi-user.target
```

# set it so that the binary can run as root ports
sudo setcap 'cap_net_bind_service=+ep' /apps/go/bin/http_server

# reload daemon
sudo systemctl daemon-reload

# enable service
sudo systemctl enable http_server.service

# start it
sudo systemctl start http_server.service

# status 
sudo systemctl status http_server.service

# create certificate
# this will put certs in /etc/letsencrypt/live/domain.com/
# this requires to run as port 80, so stop your web service first
sudo certbot --standalone  -d domain.com

# create script to deploy certs

# run renewal in cronjob

sudo crontab -e
```
0 */12 * * * certbot renew --pre-hook "systemctl stop your-service" --post-hook "systemctl start your-service" --deploy-hook deploycerts.sh --quiet
```

