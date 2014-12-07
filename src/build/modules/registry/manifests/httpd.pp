class registry::httpd {
  require registry::packages
  require registry::httpd::supervisor

  exec { '/bin/bash -c "a2enmod ssl"': }

  file { '/etc/apache2/sites-enabled/000-default':
    ensure => absent
  }

  file { '/var/www/index.html':
    ensure => absent
  }
}
