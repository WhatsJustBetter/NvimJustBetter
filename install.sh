#!/bin/bash

sudo apt update

sudo apt upgrade

sudo apt install npm

mkdir .config

mkdir .config/nvim

cd .config/nvim

sudo wget https://github.com/dashdash-studios/NvimJustBetter/blob/main/init.lua

nvim
