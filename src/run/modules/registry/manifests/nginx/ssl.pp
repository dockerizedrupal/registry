class registry::nginx::ssl {
  exec { 'openssl genrsa -out /root/devdockerCA.key 4096':
    timeout => 0,
    path => ['/usr/bin']
  }

  $subj = "/C=US/ST=Denial/L=Springfield/O=Dis/CN=$server_name"

  exec { "openssl req -x509 -new -nodes -key /root/devdockerCA.key -days 365 -subj $subj -out /root/devdockerCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /root/devdockerCA.key 4096']
  }

  exec { 'openssl genrsa -out /root/registry.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -x509 -new -nodes -key /root/devdockerCA.key -days 365 -subj $subj -out /root/devdockerCA.crt"]
  }

  exec { "openssl req -new -key /root/registry.key -subj $subj -out /root/registry.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /root/registry.key 4096']
  }

  exec { "openssl x509 -req -in /root/registry.csr -CA /root/devdockerCA.crt -CAkey /root/devdockerCA.key -CAcreateserial -out /root/registry.crt -days 365":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -new -key /root/registry.key -subj $subj -out /root/registry.csr"]
  }

  exec { 'cp /root/registry.crt /etc/ssl/certs/registry.crt':
    path => ['/bin'],
    require => Exec["openssl x509 -req -in /root/registry.csr -CA /root/devdockerCA.crt -CAkey /root/devdockerCA.key -CAcreateserial -out /root/registry.crt -days 365"]
  }

  exec { 'cp /root/registry.key /etc/ssl/private/registry.key':
    path => ['/bin'],
    require => Exec["openssl x509 -req -in /root/registry.csr -CA /root/devdockerCA.crt -CAkey /root/devdockerCA.key -CAcreateserial -out /root/registry.crt -days 365"]
  }
}
