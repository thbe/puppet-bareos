#! /bin/bash
#
# Fix missing FQDN
#

### Add FQDN to /etc/hosts ###
echo $(/opt/puppetlabs/bin/facter network) $(/opt/puppetlabs/bin/facter fqdn) >> /etc/hosts
