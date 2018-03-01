# Copyright 2008-2018 Univa Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


class tortuga_kit_munin::node::package {
  require tortuga::packages

  $pkgs = [
    'munin-node',
    'perl-Net-Netmask',
  ]

  ensure_resource('package', $pkgs, {'ensure' => 'installed'})
}

class tortuga_kit_munin::node::config {
  require tortuga_kit_munin::node::package

  include tortuga_kit_munin::config

  if ($::fqdn == $::primary_installer_hostname) {
    $is_running_on_installer = true
  } else {
    $is_running_on_installer = false
  }

  if ($is_running_on_installer) {
    # This is disabled by default 'cause it doesn't seem to work, but it'd
    # sure be nice if it did :)
    if ($tortuga_kit_munin::config::monitor_dhcp) {
      file { '/etc/munin/plugins/dhcpd3':
        ensure => link,
        target => '/usr/share/munin/plugins/dhcpd3',
      } ~>
      file { '/etc/munin/plugin-conf.d/dhcpd3':
        source => 'puppet:///modules/tortuga_kit_munin/dhcpd3',
      }
    } else {
      file { '/etc/munin/plugins/dhcpd3':
        ensure => absent,
      }

      file { '/etc/munin/plugin-conf.d/dhcpd3':
        ensure => absent,
      }
    }

    file { '/etc/munin/plugin-conf.d/mysql_innodb':
      source => 'puppet:///modules/tortuga_kit_munin/mysql_innodb',
    }

    file { '/etc/munin/plugin-conf.d/mysql':
      source => 'puppet:///modules/tortuga_kit_munin/mysql',
    }
  } else {
    # Disable NFS server monitoring on compute nodes
    file { '/etc/munin/plugins/nfsd':
      ensure => absent,
    }

    file { '/etc/munin/plugins/nfsd4':
      ensure => absent,
    }

    # Enable NFS client monitoring
    file { '/etc/munin/plugins/nfs_client':
      ensure => link,
      target => '/usr/share/munin/plugins/nfs_client',
    }

    # Disable firewall monitoring
    file { '/etc/munin/plugins/fw_packets':
      ensure => absent,
    }

    file { '/etc/munin/munin-node.conf':
      source => 'puppet:///modules/tortuga_kit_munin/munin-node.conf',
    }
  }

  if ($tortuga_kit_munin::config::monitor_postfix) {
  } else {
    file { '/etc/munin/plugins/postfix_mailvolume':
      ensure => absent,
    }

    file { '/etc/munin/plugins/postfix_mailqueue':
      ensure => absent,
    }
  }
}

class tortuga_kit_munin::node::service {
  require tortuga_kit_munin::node::config

  service { 'munin-node':
    ensure => running,
    enable => true,
  }
}

class tortuga_kit_munin::node {
  contain tortuga_kit_munin::node::package
  contain tortuga_kit_munin::node::config
  contain tortuga_kit_munin::node::service
}
