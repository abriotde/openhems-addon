#!/bin/env python3

import openhems

configFile = "/etc/openhems/openhems.yaml"

app = openhems.OpenHEMSApplication(configFile)
app.run()

