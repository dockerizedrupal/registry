class registry {
  require registry::nginx

  exec { 'mkdir -p /registry/data':
    path => ['/bin']
  }

  file { '/usr/local/lib/python2.7/dist-packages/config/config.yml':
    ensure => present,
    source => 'puppet:///modules/registry/usr/local/lib/python2.7/dist-packages/config/config.yml',
    mode => 644
  }

  file { '/var/www/repositories.php':
    ensure => present,
    content => template('registry/repositories.php.erb'),
    owner => nginx,
    group => nginx,
    mode => 755
  }
}
