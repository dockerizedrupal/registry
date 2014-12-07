class jenkins {
  require jenkins::packages
  require jenkins::supervisor

  exec { 'mkdir -p /jenkins/data':
    path => ['/bin']
  }
}
