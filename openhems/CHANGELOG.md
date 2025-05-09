# Changelog

## 0.2.10 - 2024-04-26
### Improvement
* ADD Switch witch are not switchable by home automation : It allow reduce margin because we can count heavy consumer that are not switchable to avoid black-out (on off-peak time-slots).
* ADD Sqlite3 DB to record/analyze behavior of switch : guess characteristics.
* ADD FeedbackSwitch with a modelization by polynomial regression

## 0.2.9 - 2024-04-18
### FIX
- FIX strategy/annealing : Use genetic algorythm for more reliable results.
- FIX node/solarpanel :  add tests on it and complete class attributes.

### Improvement
- MOD Improve Widget UX.
- ADD web page to get basic informations : The most important is 'version'. But ko on addon... To fix.
- ADD automatic switch : switch on when you can until X occured.
- ADD web tooltips on dynamic popup (for nodes/strategies) and update translations
- MOD strategy/solarnosell : Add some more complex parameters for finer configuration.
- MOD doc : ADD autogeneration of docstring + Update configure/usage

### Improvement

## 0.2.7 - 2024-04-07
To fix Home-Assistant addon, create /etc/openhems/openhems.yaml (config file) if not exists

## 0.2.6 - 2024-04-07
To fix Home-Assistant addon, must upgrade version for so few.

### Fix
- FIX Start even if CastException or over at init.

## 0.2.5 - 2024-04-06
To fix Home-Assistant addon, must upgrade version for so few.

### Fix
- FIX Start even if the classname is missing or miss configured.

## 0.2.4 - 2024-04-06
### Fix
- Configuration UI : /params.
- stability and start even with major configuration error

### Improvement
- ADD multi hours-ranges for contract
- ADD priority notion for devices.
- ADD SolarNoSell & SimulatedAnnealing strategies but not stable for the moment.


## 0.1.9 - 2024-02-19
### Improvement
- Publish openhems as PIP package (Same version). The goal is put it in Home-Assistant's addon.
- Lots of work done on website and hardware study but not on openhems-sample.

### Fix
- Github action python-publish.yml

## 0.1.8 - 2024-01-29
### Improvement
- ADD strategy : Use timeout on scheduled devices to respect constraints
- MOD doc : Add usage documentation
- MOD contract : API to get current pricing and in futur

### Fix

### TODO
- Use internet to get Tempo color instead of HA plugin

## 0.1.7 - 2024-01-03
### Improvement
- MOD : Multi-strategy
- MOD : Add SwitchOffStrategy with extra conditions.

### Fix
- Improve logs with Docker

### TODO
- Update UI YAML edition

## 0.1.6 - 2024-01-03
### Improvement
- MOD log for docker on stdout
- MOD : some more log.

### Fix
- FIX cast_utility.toTypeInt("0.0") crash

## 0.1.5 - 2024-12-10
### Improvement
- ADD IHM for editing YAML configuration
- ADD resilience on error: Start anyway Web server and display errors and configuration screen to fix them.
- UPDATE documentation
- ADD some translation system.
- MOD configuration : Create localization "header" for place/hours/language.

## 0.1.4 - 2024-11-18
### Improvement
- ADD Auto-génération of Emhass yaml configuration => Avoid problems
- ADD notion of Contract to manage peak-hours "dynamically".
- MOD ConfigurationManager : get sub-dict of sub-configurations
- UPDATE Emhass

### Fix
- FIX Install OpenHEMS as docker (And command VPN)
- FIX Pipelines

## 0.1.3 - 2024-11-18
### Improvement
- Aplication as a Docker

### Fix
- FIX and stabilize Emhass

## 0.1.2 - 2024-10-11
### Improvement
- EmhassStrategy
- Fatorize code
- Changelog

## 0.1.1 - 2024-10-04
### Improvement
- Ehmass POC
- Tests (FakeNetworkUpdater)
- Pipelines => Pylint, Codecov, pip
- Documentation on readthedoc
### Fix
- HomeAssistantStrategy
- Pipelines : Pylint + Codecov => Improve code reliability and lisibility

## 0.1.0 - 2024-08-25
### Improvement
- HomeAssistantStrategy
- Loging system with logrotate
- Install scripts
- Auto-Upgrade system
