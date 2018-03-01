#!/bin/sh

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

# Cache Munin packages for non-routed compute nodes

cachedir="/var/cache/tortuga/pkgs/munin"

commonpkgs="\
munin \
munin-common \
munin-node \
perl-Cache-Cache \
perl-Carp-Always \
perl-Crypt-DES \
perl-FCGI \
perl-HTML-Template \
perl-IO-Multiplex \
perl-Log-Log4perl \
perl-Net-CIDR \
perl-Net-Server \
perl-Net-SNMP \
perl-Net-Netmask \
perl-Pod-Escapes perl-Module-Pluggable perl-Pod-Simple \
perl \
perl-libs \
perl-version
"

yumcmd="yum -y --downloadonly --downloaddir=${cachedir}"

is_pkg_installed() {
    rpm --quiet -q $1
}

[ -d "${cachedir}" ] || mkdir -p $cachedir

pkgs_to_install=""
pkgs_to_reinstall=""

for pkg in $commonpkgs ; do
    if `is_pkg_installed $pkg`; then
        pkgs_to_reinstall="${pkgs_to_reinstall} ${pkg}"
    else
        pkgs_to_install="${pkgs_to_install} ${pkg}"
    fi
done

if [ -n "$pkgs_to_reinstall" ]; then
    $yumcmd reinstall $pkgs_to_reinstall
fi

if [ -n "$pkgs_to_install" ]; then
    $yumcmd install $pkgs_to_install
fi
