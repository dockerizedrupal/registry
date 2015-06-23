class registry::v2::supervisor {
  file { '/etc/supervisor/conf.d/registry_v2.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/supervisor/conf.d/registry_v2.conf',
    mode => 644
  }
}
