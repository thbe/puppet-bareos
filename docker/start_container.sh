#! /bin/bash
#
# Prepare Docker container for Bareos Puppet module testing
#

### Build Docker image ###
docker build --rm --no-cache -t bareos .

### Start Docker container ###
docker run --cap-add=SYS_ADMIN --security-opt=seccomp:unconfined --stop-signal=SIGRTMIN+3 --name bareos -p 80:80 -p 443:443 -d bareos

### Fix missing FQDN in /etc/hosts ###
docker cp add_domain.sh bareos:/tmp/add_domain.sh
docker exec bareos /tmp/add_domain.sh

### Download Puppet module thbe-bareos ###
docker exec bareos /opt/puppetlabs/bin/puppet module install thbe-bareos

### Full module test ###
docker exec bareos /opt/puppetlabs/bin/puppet apply -e 'class { "bareos": type_dir => true, type_fd => true, type_sd => true, type_webui => true, backup_clients => [ "client1.example.local", "client2.example.local" ], }'
