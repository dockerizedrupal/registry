class registry::nginx::ssl {
  exec { 'mkdir -p /registry/ssl':
    path => ['/bin']
  }

  exec { 'mkdir -p /registry/ssl/private':
    path => ['/bin'],
    require => Exec['mkdir -p /registry/ssl']
  }

  exec { 'mkdir -p /registry/ssl/certs':
    path => ['/bin'],
    require => Exec['mkdir -p /registry/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('registry/opensslCA.cnf.erb'),
    require => Exec['mkdir -p /registry/ssl/certs']
  }

  exec { 'openssl genrsa -out /registry/ssl/private/registryCA.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/opensslCA.cnf']
  }

  exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /registry/ssl/private/registryCA.key -out /registry/ssl/certs/registryCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /registry/ssl/private/registryCA.key 4096']
  }

  exec { 'openssl genrsa -out /registry/ssl/private/registry.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /registry/ssl/private/registryCA.key -out /registry/ssl/certs/registryCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('registry/openssl.cnf.erb'),
    require => Exec['openssl genrsa -out /registry/ssl/private/registry.key 4096']
  }

  exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /registry/ssl/private/registry.key -out /registry/ssl/certs/registry.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/openssl.cnf']
  }

  exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /registry/ssl/certs/registry.csr -CA /registry/ssl/certs/registryCA.crt -CAkey /registry/ssl/private/registryCA.key -out /registry/ssl/certs/registry.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -config /root/openssl.cnf -key /registry/ssl/private/registry.key -out /registry/ssl/certs/registry.csr"]
  }
}
