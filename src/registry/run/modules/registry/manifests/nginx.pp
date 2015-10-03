class registry::nginx {
  include registry::nginx::proxy_read_timeout

  if ! file_exists('/registry/ssl/certs/registry.crt') {
    require registry::nginx::ssl
  }

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

  if $http_basic_auth == "On" {
    file { '/usr/local/bin/htpasswd_generator':
      ensure => present,
      content => template('registry/htpasswd_generator.sh.erb'),
      mode => 755
    }

    bash_exec { 'htpasswd_generator':
      timeout => 0,
      require => File['/usr/local/bin/htpasswd_generator']
    }
  }
}
