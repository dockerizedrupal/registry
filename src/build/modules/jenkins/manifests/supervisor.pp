class jenkins::supervisor {
  file { '/etc/supervisor/conf.d/jenkins.conf':
    ensure => present,
    source => 'puppet:///modules/jenkins/etc/supervisor/conf.d/jenkins.conf',
    mode => 644
  }
}
