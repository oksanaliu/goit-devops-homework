#!/bin/bash

# Зупинити скрипт при помилці
set -e

echo "Starting check and installation process..."

# Оновлення списків пакетів
# || echo ... дозволяє скрипту продовжити роботу на Mac, де немає apt-get
echo "Updating package lists..."
sudo apt-get update -y || echo "Warning: apt-get not found (expected on macOS)"

# --- 1. Docker ---
if command -v docker &> /dev/null; then
    echo "Docker is already installed."
else
    echo "Installing Docker..."
    sudo apt-get install -y docker.io
    echo "Docker installed successfully."
fi

# --- 2. Docker Compose ---
if command -v docker-compose &> /dev/null; then
    echo "Docker Compose is already installed."
else
    echo "Installing Docker Compose..."
    sudo apt-get install -y docker-compose
    echo "Docker Compose installed successfully."
fi

# --- 3. Python 3 ---
if command -v python3 &> /dev/null; then
    echo "Python 3 is already installed."
else
    echo "Installing Python 3..."
    sudo apt-get install -y python3
    echo "Python 3 installed successfully."
fi

# --- 4. Pip ---
if command -v pip3 &> /dev/null; then
    echo "Pip is already installed."
else
    echo "Installing Pip..."
    sudo apt-get install -y python3-pip
    echo "Pip installed successfully."
fi

# --- 5. Django ---
if pip3 show django &> /dev/null; then
    echo "Django is already installed."
else
    echo "Installing Django..."
    pip3 install django
    echo "Django installed successfully."
fi

echo "Script finished successfully."


