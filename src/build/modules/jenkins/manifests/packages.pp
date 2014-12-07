class jenkins::packages {
  exec { '/bin/bash -c "wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -"': }

  file { '/etc/apt/sources.list.d/jenkins.list':
    ensure => present,
    source => 'puppet:///modules/jenkins/etc/apt/sources.list.d/jenkins.list'
  }

  exec { 'apt-get update':
    path => ['/usr/bin'],
    require => File['/etc/apt/sources.list.d/jenkins.list']
  }

  package {[
      'jenkins'
    ]:
    ensure => present,
    require => Exec['apt-get update'],
    before => Exec['apt-get clean']
  }

  exec { 'apt-get clean':
    path => ['/usr/bin']
  }

  exec { 'rm -rf /var/lib/apt/lists':
    path => ['/bin'],
    require => Exec['apt-get clean']
  }
}
