class registry::httpd::supervisor {
  file { '/etc/supervisor/conf.d/httpd.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/supervisor/conf.d/httpd.conf',
    mode => 644
  }
}
