class registry {
  require registry::nginx

  file { '/usr/local/lib/python2.7/dist-packages/config/config.yml':
    ensure => present,
    source => 'puppet:///modules/registry/usr/local/lib/python2.7/dist-packages/config/config.yml',
    mode => 644
  }
}
