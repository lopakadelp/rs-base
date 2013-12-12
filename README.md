# rs-base cookbook

[![Build Status](https://travis-ci.org/rightscale-cookbooks/rs-base.png?branch=master)](https://travis-ci.org/rightscale-cookbooks/rs-base)

Provides the basic recipes for setting up a RightScale instance.

# Requirements

Requires Chef 10

# Usage

Add a dependency to your cookbook's `metadata.rb`:

```ruby
depends 'rs-base'
```

Add the provided recipes in this cookbook to your run list as needed.

# Attributes

* `node['rs-base']['swap']['size']` - The swap file size in MB. This attribute must be a numeric value.
  Default is `1024`.
* `node['rs-base']['swap']['file']` - The location of the swap file. This attribute must be a valid filename.
  Default is `'/mnt/ephemeral/swapfile'`.
* `node['rs-base']['ntp']['servers']` - List of fully qualified domain names for the array of servers that are used for
  updating time.
  Default is `['time.rightscale.com', 'ec2-us-east.time.rightscale.com', 'ec2-us-west.time.rightscale.com']`.
* `node['rs-base']['rsyslog_server']` - FQDN or IP address of a remote rsyslog server. Default is `nil`.

# Recipes

## rs-base::default

All-in-one recipe to run all recipes in rs-base cookbook.

## rs-base::swap

Creates a swapfile of the specified size `node['rs-base']['swap']['size']` in the
specified location `node['rs-base']['swap']['file']` and enables it's usage.
The swap file is added to `/etc/fstab` and will persist across reboots. If the size or the
file location is invalid this recipe will fail with an error message indicating what the
failure was.

## rs-base::ntp

Configures ntp using servers in `node['rs-base']['ntp']['servers']`.

## rs-base::rsyslog

Installs and configures the rsyslog service. If `node['rs-base']['rsyslog_server']` is set, its value will be
used as the remote syslog server. Otherwise local machine is used.

## rs-base::collectd

Installs the collectd client using default configuration.

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
