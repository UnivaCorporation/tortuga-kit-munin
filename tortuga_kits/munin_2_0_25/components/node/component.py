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

import glob
import os

from tortuga.kit.installer import ComponentInstallerBase


class ComponentInstaller(ComponentInstallerBase):
    name = 'node'
    version = '2.0.25'
    os_list = [
        {'family': 'rhel', 'version': '6', 'arch': 'x86_64'},
        {'family': 'rhel', 'version': '7', 'arch': 'x86_64'},
    ]

    def action_delete_host(self, software_profile_name, nodes, *args,
                           **kargs):
        munin_var_dir = '/var/lib/munin'
        munin_conf_dir = '/etc/munin/conf.d'
        sw_profile_var_dir = os.path.join(munin_var_dir,
                                          software_profile_name)

        for node in nodes:
            for fn in glob.glob(
                    os.path.join(sw_profile_var_dir, '%s-*' % (node))):
                os.remove(fn)

            fn = os.path.join(
                munin_var_dir,
                'state-{}-{}.storable'.format(software_profile_name, node))
            if os.path.exists(fn):
                os.remove(fn)

            fn = os.path.join(munin_conf_dir, '{}.conf'.format(node))
            if os.path.exists(fn):
                os.remove(fn)
