class registry::nginx {
  exec { "htpasswd -b -c /etc/nginx/registry.htpasswd '$username' '$password'":
    timeout => 0,
    path => ['/usr/bin']
  }
}
