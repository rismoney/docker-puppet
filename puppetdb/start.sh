#!/bin/bash

# Protect against dirty shutdown.
rm -fr /var/run/puppetdb*
rm -fr /var/lock/subsys/puppetdb*

/etc/init.d/rsyslog start
/etc/init.d/postgresql start
/etc/init.d/puppetdb start

# Ugly!
tail -f /var/log/messages
