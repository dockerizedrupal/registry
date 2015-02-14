class registry {
  require registry::nginx

  exec { 'mkdir -p /registry/data':
    path => ['/bin']
  }

  file { '/usr/local/lib/python2.7/dist-packages/config/config.yml':
    ensure => present,
    content => template('registry/config.yml.erb'),
    mode => 644
  }

  file { '/var/www/index.php':
    ensure => present,
    content => template('registry/index.php.erb'),
    owner => nginx,
    group => nginx,
    mode => 755
  }
}
