class registry {
  require registry::nginx
  require registry::packages
  require registry::supervisor

  exec { '/bin/su - root -mc "pip install docker-registry"':
    timeout => 0
  }
}
