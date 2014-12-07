class registry {
  require registry::packages
  require registry::httpd

  exec { '/bin/bash -c "pip install docker-registry"': }
}
