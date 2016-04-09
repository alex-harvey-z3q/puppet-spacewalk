class spacewalk::server (
  $manage_repo         = $spacewalk::params::manage_repo,
  $repo_stage          = $spacewalk::params::repo_stage,
  $package_list        = $spacewalk::params::package_list,
  $admin_email         = $spacewalk::params::admin_email,
  $ssl_set_org         = $spacewalk::params::ssl_set_org,
  $ssl_set_org_unit    = $spacewalk::params::ssl_set_org_unit,
  $ssl_set_state       = $spacewalk::params::ssl_set_state,
  $ssl_set_country     = $spacewalk::params::ssl_set_country,
  $ssl_password        = $spacewalk::params::ssl_password,
  $ssl_set_email       = $spacewalk::params::ssl_set_email,
  $ssl_config_sslvhost = $spacewalk::params::ssl_config_sslvhost,
  $db_password         = $spacewalk::params::db_password,
) inherits spacewalk::params {

  validate_bool($manage_repo)
  if ($manage_repo) {
    if !(defined(Stage[$repo_stage])) {
      stage { $repo_stage: before => Stage['main'] }
    }

    class { 'spacewalk::repos':
      stage => $repo_stage,
    }
  }

  validate_array($package_list)
  package { $package_list:
    ensure => installed,
  }

  file { '/etc/sysconfig':
    ensure => directory,
  }

  file { '/etc/sysconfig/spacewalk.answers':
    ensure  => file,
    content => template('spacewalk/answer-file.txt.erb'),
  }

  exec { 'spacewalk-setup':
    command     => "/usr/bin/spacewalk-setup --disconnected --answer-file=/etc/sysconfig/spacewalk.answers",
    creates   => '/var/www/html/pub/RHN-ORG-TRUSTED-SSL-CERT',
    logoutput => true,
    refreshonly => true,
  }

  exec { 'enable-spacewalk-service':
    command     => '/sbin/spacewalk-service enable',
    refreshonly => true,
  }

  exec { 'start-spacewalk-service':
    command     => '/sbin/spacewalk-service start',
    refreshonly => true,
  }

  File['/etc/sysconfig']
  ->
  File['/etc/sysconfig/spacewalk.answers']
  ->
  Package[$package_list]
  ~>
  Exec['spacewalk-setup']
  ~>
  Exec['enable-spacewalk-service']
  ~>
  Exec['start-spacewalk-service']
}
