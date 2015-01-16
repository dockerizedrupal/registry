class registry::nginx::ssl {
  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('registry/opensslCA.cnf.erb')
  }

  exec { 'openssl genrsa -out /registry/ssl/private/registryCA.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/opensslCA.cnf']
  }

  exec { "openssl req -x509 -new -nodes -key /registry/ssl/private/registryCA.key -days 365 -config /root/opensslCA.cnf -out /registry/ssl/certs/registryCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /registry/ssl/private/registryCA.key 4096']
  }

  exec { 'openssl genrsa -out /registry/ssl/private/registry.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -x509 -new -nodes -key /registry/ssl/private/registryCA.key -days 365 -config /root/opensslCA.cnf -out /registry/ssl/certs/registryCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('registry/openssl.cnf.erb'),
    require => Exec['openssl genrsa -out /registry/ssl/private/registry.key 4096']
  }

  exec { "openssl req -sha256 -new -key /registry/ssl/private/registry.key -config /root/openssl.cnf -out /registry/ssl/certs/registry.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/openssl.cnf']
  }

  exec { "openssl x509 -req -in /registry/ssl/certs/registry.csr -CA /registry/ssl/certs/registryCA.crt -CAkey /registry/ssl/private/registryCA.key -CAcreateserial -out /registry/ssl/certs/registry.crt -days 365":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -key /registry/ssl/private/registry.key -config /root/openssl.cnf -out /registry/ssl/certs/registry.csr"]
  }
}
