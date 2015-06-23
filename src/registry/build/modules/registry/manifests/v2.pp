class registry::v2 {
  require registry::v2::supervisor
  require registry::go

  bash_exec { 'go get github.com/docker/distribution/cmd/registry': }

  file { '/go/src/github.com/docker/distribution/cmd/registry/config.yml':
    ensure => present,
    source => 'puppet:///modules/registry/go/src/github.com/docker/distribution/cmd/registry/config.yml',
    mode => 644,
    require => Bash_exec['go get github.com/docker/distribution/cmd/registry']
  }
}
