#!/bin/bash
#will make the services for the pool, based on the pool exe location of /usr/local/bin/poolbin
if [ "${EUID:-$(id -u)}" -ne 0 ]
then
        echo "Please run as root"
        exit
fi

user="callisto"
coin="clo"
config_dir="$PWD/configs"
poolbinary="$PWD/build/bin/open-callisto-pool"

#add the intended user directory
getent passwd $user > /dev/null
if [ $? -ne 0 ]; then
printf "\n################################\nAdding user: $user\n################################\n\n"
useradd $user -s /bin/bash -m
fi

if [ ! -e $config_dir ] || [ ! -e $poolbinary ]
then
echo missing config dir or pool binary, exiting
exit 1
fi

echo "
[Unit]
Description=$coin-api

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/api.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-api.service

echo "
[Unit]
Description=$coin-stratum2b

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/stratum2b.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-stratum2b.service


echo "
[Unit]
Description=$coin-stratum4b

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/stratum4b.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-stratum4b.service


echo "
[Unit]
Description=$coin-stratum9b


[Service]
Type=simple
ExecStart=$poolbinary $config_dir/stratum9b.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-stratum9b.service


echo "
[Unit]
Description=$coin-unlocker


[Service]
Type=simple
ExecStart=$poolbinary $config_dir/unlocker.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-unlocker.service

echo "
[Unit]
Description=$coin-payout

[Service]
Type=simple
ExecStart=$poolbinary $config_dir/payout.json

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/$coin-payout.service

systemctl daemon-reload

systemctl enable $coin-api
systemctl enable $coin-stratum2b
systemctl enable $coin-stratum4b
systemctl enable $coin-stratum9b
#systemctl enable $coin-unlocker
#systemctl enable $coin-payout

systemctl start $coin-api
systemctl start $coin-stratum2b
systemctl start $coin-stratum4b
systemctl start $coin-stratum9b
#systemctl start $coin-unlocker
#systemctl start $coin-payout



