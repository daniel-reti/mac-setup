#!/bin/bash

set -e

# Source utility functions
source ./scripts/utils.sh

# Create the .config directory if it doesn't exist
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/alacritty"

# Copy alacritty configuration
if [ -f "./configs/alacritty.toml" ]; then
  step "Setting up Alacritty configuration..."
  if [ ! -f "$HOME/.config/alacritty/alacritty.toml" ]; then
    cp "./configs/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
    print_success "Alacritty configuration installed"
  elif files_are_identical "$HOME/.config/alacritty/alacritty.toml" "./configs/alacritty.toml"; then
    print_success_muted "Alacritty configuration already up to date"
  elif confirm_override "$HOME/.config/alacritty/alacritty.toml" "./configs/alacritty.toml" "Alacritty configuration"; then
    cp "./configs/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
    print_success "Alacritty configuration installed"
  else
    print_muted "Skipping Alacritty configuration"
  fi
else
  print_warning "Alacritty configuration file not found"
fi
