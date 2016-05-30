class spacewalk::server::setup (
  $db_backend          = $spacewalk::server::db_backend,
  $admin_email         = $spacewalk::server::admin_email,
  $ssl_set_org         = $spacewalk::server::ssl_set_org,
  $ssl_set_org_unit    = $spacewalk::server::ssl_set_org_unit,
  $ssl_set_city        = $spacewalk::server::ssl_set_city,
  $ssl_set_state       = $spacewalk::server::ssl_set_state,
  $ssl_set_country     = $spacewalk::server::ssl_set_country,
  $ssl_password        = $spacewalk::server::ssl_password,
  $ssl_set_email       = $spacewalk::server::ssl_set_email,
  $ssl_config_sslvhost = $spacewalk::server::ssl_config_sslvhost,
  $db_password         = $spacewalk::server::db_password,
  $db_port             = $spacewalk::server::db_port,
) {

  file { '/etc/sysconfig':
    ensure => directory,
  }

  file { '/etc/sysconfig/spacewalk.answers':
    ensure  => file,
    content => template('spacewalk/spacewalk.answers.erb'),
  }

  exec { 'spacewalk-setup':
    command     => '/usr/bin/spacewalk-setup --disconnected --answer-file=/etc/sysconfig/spacewalk.answers',
    refreshonly => true,
    timeout     => 0,
  }

  File['/etc/sysconfig']
  ->
  File['/etc/sysconfig/spacewalk.answers']
  ->
  Exec['spacewalk-setup']

}
