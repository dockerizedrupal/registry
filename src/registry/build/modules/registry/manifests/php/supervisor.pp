class registry::php::supervisor {
  file { '/etc/supervisor/conf.d/php.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/supervisor/conf.d/php.conf',
    mode => 644
  }
}
