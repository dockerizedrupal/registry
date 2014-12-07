class registry {
  require registry::packages

  exec { 'pip install docker-registry':
    path => ['/usr/bin']
  }
}
