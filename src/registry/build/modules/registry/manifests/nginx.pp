class registry::nginx {
  require registry::nginx::packages
  require registry::nginx::supervisor

  file { '/etc/nginx/conf.d/example_ssl.conf':
    ensure => absent
  }

  file { '/etc/nginx/nginx.conf':
    ensure => present,
    source => 'puppet:///modules/registry/etc/nginx/nginx.conf',
    mode => 644
  }

  bash_exec { 'mkdir -p /etc/htpasswd': }
}
