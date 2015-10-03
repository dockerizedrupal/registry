class registry::go {
  file { '/tmp/go1.5.1.linux-amd64.tar.gz':
    ensure => present,
    source => 'puppet:///modules/registry/tmp/go1.5.1.linux-amd64.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf go1.5.1.linux-amd64.tar.gz':
    require => File['/tmp/go1.5.1.linux-amd64.tar.gz']
  }

  bash_exec { 'mv /tmp/go /usr/local/src/go':
    require => Bash_exec['cd /tmp && tar xzf go1.5.1.linux-amd64.tar.gz']
  }

  file { '/etc/profile.d/go.sh':
    ensure => present,
    source => 'puppet:///modules/registry/etc/profile.d/go.sh',
    mode => 755
  }
}
