class registry::nginx {
  file { '/etc/nginx/conf.d/default.conf':
    ensure => present,
    content => template('registry/default.conf.erb'),
    mode => 644
  }

  file { '/etc/nginx/conf.d/default-ssl.conf':
    ensure => present,
    content => template('registry/default-ssl.conf.erb'),
    mode => 644
  }

  exec { "htpasswd -b -c /etc/nginx/registry.htpasswd '$username' '$password'":
    timeout => 0,
    path => ['/usr/bin']
  }
}
