node default {
  file { '/run.sh':
    ensure => present,
    source => '/tmp/build/run.sh',
    mode => 755
  }
}