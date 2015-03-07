class registry::supervisor {
  file { '/etc/supervisor/conf.d/registry.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/supervisor/conf.d/registry.conf',
    mode => 644
  }
}
