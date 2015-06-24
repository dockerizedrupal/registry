class registry {
  require registry::packages
  require registry::v2
  require registry::nginx
  require registry::php

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
