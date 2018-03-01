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

import os

from tortuga.kit.installer import KitInstallerBase
from tortuga.kit.manager import KitManager
from tortuga.os_utility import tortugaSubprocess


class MuninInstaller(KitInstallerBase):
    puppet_modules = ['univa-tortuga_kit_munin']

    def action_post_install(self, *args, **kwargs):
        super().action_post_install(*args, **kwargs)

        #
        # Cache Munin packages and dependencies from EPEL
        #
        os.system(os.path.join(self.install_path, 'bin', "dl.sh"))

        k = KitManager().getKit('munin')

        kit_repo_dir = os.path.join(
            self.config_manager.getReposDir(),
            k.getKitRepoDir()
        )

        #
        # If cache directory exists, copy to 'kitRepoDir' (the default
        # location for kit packages)
        #
        if os.path.isdir('/var/cache/tortuga/pkgs/munin'):
            tortugaSubprocess.executeCommandAndIgnoreFailure(
                'rsync -a {}/ {}'.format(
                    '/var/cache/tortuga/pkgs/munin', kit_repo_dir)
            )
            tortugaSubprocess.executeCommandAndIgnoreFailure(
                'createrepo {}'.format(kit_repo_dir))
