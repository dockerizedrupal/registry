class registry {
  exec { 'pip install docker-registry':
    path => ['/usr/bin']
  }
}
