class registry::packages {
  package {[
      'build-essential',
      'python-dev',
      'libevent-dev',
      'liblzma-dev',
      'apache2-utils',
      'swig'
    ]:
    ensure => present
  }
}
