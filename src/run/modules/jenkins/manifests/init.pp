class jenkins {
  exec { 'chown -R jenkins.jenkins /jenkins':
    path => ['/bin']
  }
}
