class gems {
  package {
  'fpm':
    ensure   => installed,
    provider => gem,
  }
}
