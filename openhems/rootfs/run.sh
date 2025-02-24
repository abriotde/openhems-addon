#!/bin/bash

# Inject Home Assistant URL and token from add-on options
export HA_URL="${HA_URL}"
export HA_TOKEN="${HA_TOKEN}"

# Start OpenHEMS
python /run.py
