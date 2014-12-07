class registry {
  require registry::packages
  require registry::httpd
  require registry::supervisor

  exec { '/bin/bash -c "pip install docker-registry"':
    timeout => 0
  }
}
