class registry {
  require registry::nginx
  require registry::php
  require registry::packages
  require registry::supervisor

  exec { '/bin/su - root -mc "pip install docker-registry"':
    timeout => 0
  }

  file { '/var/www':
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    owner => nginx,
    group => nginx,
    source => 'puppet:///modules/registry/var/www'
  }
}
