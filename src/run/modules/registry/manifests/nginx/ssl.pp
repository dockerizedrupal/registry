class registry::nginx::ssl {
  exec { 'openssl genrsa -out /registry/ssl/private/registryCA.key 4096':
    timeout => 0,
    path => ['/usr/bin']
  }

  exec { "openssl req -x509 -new -nodes -key /registry/ssl/private/registryCA.key -days 365 -subj /C=/ST=/L=/O=/CN=registry -out /registry/ssl/certs/registryCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /registry/ssl/private/registryCA.key 4096']
  }

  exec { 'openssl genrsa -out /registry/ssl/private/registry.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -x509 -new -nodes -key /registry/ssl/private/registryCA.key -days 365 -subj /C=/ST=/L=/O=/CN=registry -out /registry/ssl/certs/registryCA.crt"]
  }

  $subj = "/C=/ST=/L=/O=/CN=$server_name"

  exec { "openssl req -sha256 -new -key /registry/ssl/private/registry.key -subj $subj -out /registry/ssl/certs/registry.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /registry/ssl/private/registry.key 4096']
  }

  exec { "openssl x509 -req -in /registry/ssl/certs/registry.csr -CA /registry/ssl/certs/registryCA.crt -CAkey /registry/ssl/private/registryCA.key -CAcreateserial -out /registry/ssl/certs/registry.crt -days 365":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -key /registry/ssl/private/registry.key -subj $subj -out /registry/ssl/certs/registry.csr"]
  }
}
