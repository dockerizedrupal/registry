class registry {
  require registry::nginx
  require registry::timezone

  file { '/var/www/index.php':
    ensure => present,
    content => template('registry/index.php.erb'),
    owner => nginx,
    group => nginx,
    mode => 755
  }

  bash_exec { 'mkdir -p /registry/data': }
}
