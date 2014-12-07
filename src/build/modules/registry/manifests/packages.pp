class registry::packages {
  package {[
      'build-essential',
      'python-dev',
      'libevent-dev',
      'liblzma-dev'
    ]:
    ensure => present
  }
}
