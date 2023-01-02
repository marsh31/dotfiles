#!/bin/bash

sudo systemctl status clamav-daemon && sudo systemctl status clamav-freshclam
freshclam -V
