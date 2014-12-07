class registry::packages {
  exec { 'apt-get update':
    path => ['/usr/bin']
  }

  package {[
      'build-essential',
      'python-dev',
      'libevent-dev',
      'liblzma-dev'
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