class registry::nginx::supervisor {
  file { '/etc/supervisor/conf.d/nginx.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/supervisor/conf.d/nginx.conf',
    mode => 644
  }
}
