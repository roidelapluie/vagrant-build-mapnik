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
  exec {
    'configure mapnik':
      command => '/usr/bin/python scons/scons.py configure PREFIX=/opt/mapnik-install',
      cwd     => '/opt/mapnik-2.0.0',
      require => [Exec['extract mapnik'], File['mapnik install']],

  }
  exec {
    'build mapnik':
      command => '/usr/bin/screen -d -m /usr/bin/python scons/scons.py',
      cwd     => '/opt/mapnik-2.0.0',
      require => Exec['configure mapnik'],
  }

  notify {
    'see mapnik':
      message => 'To see mapnik compilation, log in as root and run screen -r',
      require => Exec ['build mapnik']
  }
}
