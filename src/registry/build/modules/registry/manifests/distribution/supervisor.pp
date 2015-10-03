class registry::distribution::supervisor {
  file { '/etc/supervisor/conf.d/distribution.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/supervisor/conf.d/distribution.conf',
    mode => 644
  }
}
