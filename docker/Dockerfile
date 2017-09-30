### Dockerfile
#
# VERSION:
#   1.0
#
# DESCRIPTION:
#   Create CentOS Linux 7 docker base image with Puppet and EPEL
#
# AUTHOR:
#   Thomas Bendler <project@bendler-net.de>
#
# COMMENTS:
#
# BUILD:
#   wget https://raw.githubusercontent.com/thbe/puppet-bareos/master/docker/Dockerfile
#   docker build --rm --no-cache -t bareos .
#
# USAGE:
#   docker run --privileged --name bareos -p 80:80 -p 443:443 -d bareos
#   docker logs bareos
#   docker exec -ti <container_id> /bin/bash
#

# Smallest base image, just to launch a container
FROM centos/systemd
ENV container docker
MAINTAINER Thomas Bendler, project@bendler-net.de

# Set locale to en_US.utf-8
ENV LANG en_US.UTF-8
ENV TERM xterm

# Expose standard http port
EXPOSE 80 443

# Add additional repositories
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# Update base image
RUN yum clean all
RUN yum -y update && yum clean all

# Prepare base image with standard tools
RUN yum -y install vim-common vim-enhanced curl wget && yum clean all
RUN yum -y install net-tools gpm-libs perl-libs tar && yum clean all
RUN yum -y install redhat-lsb-core cronie && yum clean all

# Install puppet
RUN yum -y install puppet-agent && yum clean all

# Start systemd
CMD ["/usr/sbin/init"]
