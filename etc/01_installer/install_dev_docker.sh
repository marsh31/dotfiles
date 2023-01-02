#!/bin/bash

yes | sudo pacman -S docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
