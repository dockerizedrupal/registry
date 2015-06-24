class registry::v1::packages {
  package {[
      'build-essential',
      'python-dev',
      'libevent-dev',
      'liblzma-dev',
      'swig',
      'python-pip'
    ]:
    ensure => present
  }
}
