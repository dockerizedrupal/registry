node default {
  file { '/etc/puppet/manifests/run.pp':
    ensure => present,
    source => '/tmp/build/etc/puppet/manifests/run.pp',
  }
}