class registry::packages {
  exec { 'apt-get update':
    path => ['/usr/bin']
  }

  package {[
      'python-dev',
      'liblzma-dev',
      'libevent-dev',
      'build-essential',
      'python-pip'
    ]:
    ensure => present,
    require => Exec['apt-get update'],
    before => Exec['apt-get clean']
  }

  exec { 'apt-get clean':
    path => ['/usr/bin']
  }

  exec { 'rm -rf /var/lib/apt/lists':
    path => ['/bin'],
    require => Exec['apt-get clean']
  }
}
