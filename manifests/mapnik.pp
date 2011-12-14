node default {
  class { 'rpms':; }
  class { 'gems': require  => Class['rpms']; }
  class { 'build': require => Class['gems']; }
}
