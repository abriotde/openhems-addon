#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

# Inject Home Assistant URL and token from add-on options
HA_URL=$(bashio::config 'ha_url')
HA_TOKEN=$(bashio::config 'ha_token')

export HA_URL
export HA_TOKEN

# Start OpenHEMS
python3 /app/run.py
