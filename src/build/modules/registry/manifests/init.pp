class registry {
  require registry::packages

  exec { '/bin/bash -c "pip install docker-registry"': }
}
