class registry::nginx::timeout {
  file { '/etc/nginx/conf.d/timeout.conf':
    ensure => present,
    content => template('registry/timeout.conf.erb'),
    mode => 644
  }
}
