Compute nodes must have access to EPEL (Internet access) in order to install
the munin kit.

Enable the firewall component on the installer if not using site-specific NAT
configuration.

Install epel-release on compute nodes from:

http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

## Enable Apache HTTP server status reporting

cp server-status.conf /etc/httpd.conf.d/
apachectl -k graceful
