class registry::nginx::proxy_read_timeout {
  file { '/etc/nginx/conf.d/proxy_read_timeout.conf':
    ensure => present,
    content => template('registry/proxy_read_timeout.conf.erb'),
    mode => 644
  }
}
