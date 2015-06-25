class registry::v1::supervisor {
  file { '/etc/supervisor/conf.d/registry_v1.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/supervisor/conf.d/registry_v1.conf',
    mode => 644
  }
}
