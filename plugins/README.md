Run install.sh to install plugins

    ./install.sh

Reload munin-node

    service munin-node restart

Force refresh (or wait...)

    su -s /bin/bash -l munin munin-cron
