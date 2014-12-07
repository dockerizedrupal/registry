class registry::nginx {
  file { '/etc/nginx/conf.d/registry.conf':
    ensure => present,
    source => 'puppet:///modules/registryetc/nginx/conf.d/registry.conf',
    mode => 644
  }
}
