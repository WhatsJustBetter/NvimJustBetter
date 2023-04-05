#!/bin/bash

sudo apt update

sudo apt upgrade

sudo apt install npm

mkdir .config

mkdir .config/nvim

cd .config/nvim

sudo wget https://raw.githubusercontent.com/dashdash-studios/NvimJustBetter/main/init.lua

nvim
