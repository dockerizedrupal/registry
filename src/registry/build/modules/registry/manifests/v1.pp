class registry::v1 {
  require registry::v1::packages

  bash_exec { 'pip install docker-registry':
    timeout => 0
  }
}
