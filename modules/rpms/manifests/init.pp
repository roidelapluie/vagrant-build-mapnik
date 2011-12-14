class rpms {
  $packages=[
    'rpm-build',
    'boost-devel',
    'libpng-devel',
    'libjpeg-devel',
    'libicu-devel',
    'freetype-devel',
    'libxml2-devel',
    'python-devel',
    'subversion',
    'cmake',
    'boost',
    'libtool',
    'libtiff-devel',
    'proj',
    'proj-devel',
    'libtool-ltdl-devel',
    'libcurl-devel',
    'postgis',
    'postgresql-devel',
    'screen'
  ]

  yumrepo {
    'epel':
      baseurl  => "http://mirror.eurid.eu/epel/6/$::hardwaremodel/",
      descr     => 'Extra Packages for Enterprise Linux 6.x',
      gpgcheck => 0,
      enabled  => 1,
  }

  package {
    $packages:
      require => Yumrepo['epel'],
      ensure  => installed,
  }
}
