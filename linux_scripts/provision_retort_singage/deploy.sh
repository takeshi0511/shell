#!/bin/bash
# For only hideo.

rm -rf /var/www/hideo/*
cp -R ~/git/hideo/* /var/www/hideo

echo ""
echo "deploy complete!!"
