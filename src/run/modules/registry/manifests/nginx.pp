class registry::nginx {
  require registry::nginx::ssl

  file { '/etc/nginx/conf.d/registry.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/nginx/conf.d/registry.conf',
    mode => 644
  }

  exec { "htpasswd -b -c /etc/nginx/registry.htpasswd root $password":
    timeout => 0,
    path => ['/usr/bin']
  }
}
