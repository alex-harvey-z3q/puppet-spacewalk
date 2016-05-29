class spacewalk::server::service {
  service { 'spacewalk-service':
    ensure   => running,
    start    => 'spacewalk-service start',
    stop     => 'spacewalk-service stop',
    restart  => 'spacewalk-service restart',
    status   => 'spacewalk-service status',
    provider => base,
  }
}
