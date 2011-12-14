class build {
  exec {
    'get mapnik':
      command => '/usr/bin/wget -O /tmp/mapnik.tar.bz2 https://github.com/downloads/mapnik/mapnik/mapnik-2.0.0.tar.bz2',
      creates => '/tmp/mapnik.tar.bz2'
  }
  file { 'mapnik install':
    ensure => directory,
    path   => '/opt/mapnik-install',
  }
  exec {
    'extract mapnik':
      command => '/bin/tar xvf /tmp/mapnik.tar.bz2 -C /opt',
      creates => '/opt/mapnik-2.0.0',
      require => Exec['get mapnik'],
  }
  file {
    '/usr/local/bin/build_mapnik.sh':
      source => 'puppet:///modules/build/build_mapnik.sh',
      mode   => '0755',
  }
  exec {
    'build mapnik':
      command => '/usr/bin/screen -d -m /usr/local/bin/build_mapnik.sh',
      cwd     => '/opt/mapnik-2.0.0',
      require => [File['/usr/local/bin/build_mapnik.sh'], Exec['extract mapnik']],

  }
  notify {
    'see mapnik':
      message  => 'To see mapnik compilation, log in as vagrant and run sudo screen -r',
      require  => Exec ['build mapnik'],
  }
}
