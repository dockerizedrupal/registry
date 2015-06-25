class registry::v1 {
  require registry::v1::packages
  require registry::v1::supervisor

  file { '/tmp/docker-registry-1-0.9.1.tar.gz':
    ensure => present,
    source => 'puppet:///modules/registry/tmp/docker-registry-1-0.9.1.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf docker-registry-1-0.9.1.tar.gz':
    require => File['/tmp/docker-registry-1-0.9.1.tar.gz']
  }

  bash_exec { 'pip install file:///tmp/docker-registry-1-0.9.1/depends/docker-registry-core':
    require => Bash_exec['cd /tmp && tar xzf docker-registry-1-0.9.1.tar.gz']
  }

  bash_exec { 'pip install file:///tmp/docker-registry-1-0.9.1#egg=docker-registry[bugsnag,newrelic,cors]':
    require => Bash_exec['pip install file:///tmp/docker-registry-1-0.9.1/depends/docker-registry-core']
  }

  bash_exec { 'sed -i "s/ssl_version=PROTOCOL_SSLv3/ssl_version=PROTOCOL_SSLv23/g" /usr/local/lib/python2.7/dist-packages/gevent/ssl.py':
    require => Bash_exec['pip install file:///tmp/docker-registry-1-0.9.1#egg=docker-registry[bugsnag,newrelic,cors]']
  }
}
