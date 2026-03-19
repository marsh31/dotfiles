#!/bin/bash

sudo cp ./pacman-mirrors-fasttrack.timer   /etc/systemd/system/pacman-mirrors-fasttrack.timer
sudo cp ./pacman-mirrors-fasttrack.service /etc/systemd/system/pacman-mirrors-fasttrack.service

sudo systemctl daemon-reload
sudo systemctl enable pacman-mirrors-fasttrack.timer
sudo systemctl start  pacman-mirrors-fasttrack.timer



