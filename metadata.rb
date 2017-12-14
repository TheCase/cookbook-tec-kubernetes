name             'tec-kubernetes'
maintainer       '311cub'
maintainer_email 'chef@repulsor.net'
license          'All rights reserved'
description      'Installs/Configures kubernetes and other related bits'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'docker'
depends 'swap_device'
depends 'poise-archive'
depends 'systemd'
depends 'sysctl'
