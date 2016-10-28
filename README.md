# jupyterhub

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with jupyterhub](#setup)
    * [What jupyterhub affects](#what-jupyterhub-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with jupyterhub](#beginning-with-jupyterhub)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A puppet module to manage the install and configuration of jupyterhub.

## Module Description

This module is early in its development. At this point it has been tested with the defaults
on Ubuntu 14.04 and works but further testing is needed.

This module is intended to install and configure jupyterhub.

## Setup

### Setup Requirements **OPTIONAL**

If `manage_sudo` is true, then the saz/sudo module must be in the module path.
I recommended managing sudo outside of this module in production if you are
going to be using the sudo spawner.

### Beginning with jupyterhub

At a minimum you need to manage the necessary ssl cert and key to ensure it is on the server, then
add the jupyterhub class
```
class {'jupyterhub'
  ssl_key  => '/etc/ssl/example.key',
  ssl_cert => '/etc/ssl/example.cert',
}
```
## Usage
All configuration is done with parameters against the jupyterhub class. All other classes
private and shouldn't be called directly.

## Reference

### Classes

#### Class: `jupyterhub`

All configuration parameters are passed to this class.

##### Parameters:


#### Class: `jupyterhub::install`

This installs jupyterhub and its dependencies. A python virtual environment is used
to keep everything separate from the system python.

#### Class: `jupyterhub::configure`

This class manages the jupyterhub config files.

#### Class: `jupyterhub::service`

This class creates the service file and manages the jupyterhub service.

#### Class: `jupyterhub::params`

What it says on the tin, manages default parameters.

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
