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


class tortuga_kit_munin::master::package {
  require tortuga::packages

  package { 'munin':
    ensure => installed,
  }
}

define tortuga_kit_munin::master::create_munin_node (
  $softwareprofile
) {
  # Do not create an entry for the installer itself; there is already a
  # default 'localhost' entry created at install time.
  if ($name != $::fqdn) {
    file { "/etc/munin/conf.d/${name}.conf":
      content => "[${softwareprofile};${name}]
    address ${name}
",
    }
  }
}

define tortuga_kit_munin::master::create_munin_group (
  $data
) {
  tortuga_kit_munin::master::create_munin_node { $data[$name]:
    softwareprofile => $name,
  }
}

class tortuga_kit_munin::master::config {
  require tortuga_kit_munin::master::package

  include tortuga_kit_munin::config

  $result = get_component_node_list($tortuga_kit_munin::config::kit_name, 'node')

  $enabled_software_profiles = split(inline_template("<%= @result.keys.sort.join(',') %>"), ",")

  tortuga_kit_munin::master::create_munin_group { $enabled_software_profiles:
    data => $result
  }
}

class tortuga_kit_munin::master {
  contain tortuga_kit_munin::master::package
  contain tortuga_kit_munin::master::config

  Class['tortuga_kit_munin::master::config'] ~>
    Class['tortuga::installer::apache::server']
}
