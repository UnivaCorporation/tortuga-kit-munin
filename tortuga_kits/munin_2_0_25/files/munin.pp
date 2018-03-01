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


define symlink_munin_plugin($target='') {
  if ($target != '') {
    $symlink = $target
  } else {
    $symlink = "/etc/munin/plugins/${name}"
  }
}

class munin::node::mysql {
  symlink_munin_plugin { 'mysql_bin_relay_log':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_commands':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_connections':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_files_tables':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_bpool':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_bpool_act':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_insert_buf':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_io':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_io_pend':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_log':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_rows':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_semaphores':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_innodb_tnx':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_myisam_indexes':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_network_traffic':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_qcache':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_qcache_mem':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_replication':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_select_types':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_slow':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_sorts':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_table_locks':
    target => '/usr/share/munin/plugins/mysql_',
  }

  symlink_munin_plugin { 'mysql_tmp_tables':
    target => '/usr/share/munin/plugins/mysql_',
  }
}

class munin::node::apache {
  symlink_munin_plugin { 'apache_accesses': }
  symlink_munin_plugin { 'apache_processes': }
  symlink_munin_plugin { 'apache_value': }
}

include munin::node::mysql
