class registry::nginx::ssl {
  bash_exec { 'mkdir -p /registry/ssl': }

  bash_exec { 'mkdir -p /registry/ssl/private':
    require => Bash_exec['mkdir -p /registry/ssl']
  }

  bash_exec { 'mkdir -p /registry/ssl/certs':
    require => Bash_exec['mkdir -p /registry/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('registry/opensslCA.cnf.erb'),
    require => Bash_exec['mkdir -p /registry/ssl/certs']
  }

  bash_exec { 'openssl genrsa -out /registry/ssl/private/registryCA.key 4096':
    timeout => 0,
    require => File['/root/opensslCA.cnf']
  }

  bash_exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /registry/ssl/private/registryCA.key -out /registry/ssl/certs/registryCA.crt":
    timeout => 0,
    require => Bash_exec['openssl genrsa -out /registry/ssl/private/registryCA.key 4096']
  }

  bash_exec { 'openssl genrsa -out /registry/ssl/private/registry.key 4096':
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /registry/ssl/private/registryCA.key -out /registry/ssl/certs/registryCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('registry/openssl.cnf.erb'),
    require => Bash_exec['openssl genrsa -out /registry/ssl/private/registry.key 4096']
  }

  bash_exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /registry/ssl/private/registry.key -out /registry/ssl/certs/registry.csr":
    timeout => 0,
    require => File['/root/openssl.cnf']
  }

  bash_exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /registry/ssl/certs/registry.csr -CA /registry/ssl/certs/registryCA.crt -CAkey /registry/ssl/private/registryCA.key -out /registry/ssl/certs/registry.crt":
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -new -config /root/openssl.cnf -key /registry/ssl/private/registry.key -out /registry/ssl/certs/registry.csr"]
  }
}
