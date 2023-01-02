#!/bin/bash

sudo pacman -S docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
