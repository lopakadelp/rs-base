#!/usr/bin/env bats
DEFAULT_PLUGIN_DIR=""
if uname -a | grep ubuntu;
  then DEFAULT_PLUGIN_DIR="/etc/collectd/plugins"
  else DEFAULT_PLUGIN_DIR="/etc/collectd.d"
fi


@test "Verify collectd process is running." {
  pgrep collectd
}

@test "Verfiy remote collectd server is configured" {
  grep sketchy $DEFAULT_PLUGIN_DIR/network.conf
}

@test "Verify cpu.conf was created" {
  [ -e $DEFAULT_PLUGIN_DIR/cpu.conf ]
}

@test "Verify df.conf was created" {
  [ -e $DEFAULT_PLUGIN_DIR/df.conf ]
}

@test "Verify load.conf was created" {
  [ -e $DEFAULT_PLUGIN_DIR/load.conf ]
}

@test "Verify disk.conf was created" {
  [ -e $DEFAULT_PLUGIN_DIR/disk.conf ]
}

@test "Verify memory.conf was created" {
  [ -e $DEFAULT_PLUGIN_DIR/memory.conf ]
}

@test "Verify processes.conf was created" {
  [ -e $DEFAULT_PLUGIN_DIR/processes.conf ]
}

@test "Verify users.conf was created" {
  [ -e $DEFAULT_PLUGIN_DIR/users.conf ]
}

@test "Check for process collectdmon running" {
  ps aux | grep collectdmon | grep -v grep 
}

@test "Verify receiving socket opened by the server" {
  netstat -lnp | grep collectd
}

@test "Check errorlog to make sure write plugin is working" {
  LOG_LOCATION=""
  if uname -a | grep Ubuntu;
  then LOG_LOCATION="/var/log/syslog";
  else LOG_LOCATION="/var/log/messages";
  fi

  if tail -n 20 $LOG_LOCATION | grep -q "you didn't load any write plugins";
  then
    return 1; # We found the string, so we have a problem with write plugin
  else
    return 0;
  fi
}

@test "Verify collectd is sending data" {
  # Use a 10 second timeout, this always catches two messages.  
  # We store results in a file and pipe to 'true' because the timeout command
  # will return exit status 124 when it expires and this causes test to fail.
  timeout 10s tcpdump -i eth0 -p -n -s 1500 udp port 3011 > /tmp/tcpdump | true; 
  if grep 3011 /tmp/tcpdump;
  then
     rm /tmp/tcpdump
     return 0 
  fi
  rm /tmp/tcpdump
  return 1
}


