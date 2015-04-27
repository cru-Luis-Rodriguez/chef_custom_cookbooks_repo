maintainer       'Tacit Knowledge, Inc.'
maintainer_email 'aem-cookbook-dev@googlegroups.com'
license          'Apache 2.0'
name             'aem'
description      'Installs/Configures Adobe AEM'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
#version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))
version		 '0.1.4'

recipe 'aem::author', 'Installs AEM Author instance.'
recipe 'aem::publish', 'Installs AEM Publish instance.'
recipe 'aem::dispatcher', 'Installs AEM dispatcher Apache module.'

supports 'centos' 'ubuntu'

depends 'apache2'
depends 'ark', '~> 0.8.2'
depends 'iptables'
depends 'java'
depends "aws"
depends "curl"
depends "apt"
