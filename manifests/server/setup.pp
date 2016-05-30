class spacewalk::server::setup (
  $db_backend          = $spacewalk::params::db_backend,
  $admin_email         = $spacewalk::params::admin_email,
  $ssl_set_org         = $spacewalk::params::ssl_set_org,
  $ssl_set_org_unit    = $spacewalk::params::ssl_set_org_unit,
  $ssl_set_state       = $spacewalk::params::ssl_set_state,
  $ssl_set_country     = $spacewalk::params::ssl_set_country,
  $ssl_password        = $spacewalk::params::ssl_password,
  $ssl_set_email       = $spacewalk::params::ssl_set_email,
  $ssl_config_sslvhost = $spacewalk::params::ssl_config_sslvhost,
  $db_password         = $spacewalk::params::db_password,
  $db_port             = $spacewalk::params::db_port,
) {

  file { '/etc/sysconfig':
    ensure => directory,
  }

  file { '/etc/sysconfig/spacewalk.answers':
    ensure  => file,
    content => template('spacewalk/answer-file.txt.erb'),
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
