class registry::v1::packages {
  package {[
      'build-essential',
      'python-dev',
      'libevent-dev',
      'liblzma-dev',
      'apache2-utils',
      'swig',
      'python-pip'
    ]:
    ensure => present
  }
}
