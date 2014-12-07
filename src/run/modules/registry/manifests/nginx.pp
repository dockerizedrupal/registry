class registry::nginx {
  file { '/etc/nginx/conf.d/registry.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/nginx/conf.d/registry.conf',
    mode => 644
  }

  exec { "/bin/bash -c \"htpasswd -Bb -c /etc/nginx/registry.htpasswd root $password\"":
    timeout => 0
  }
}
