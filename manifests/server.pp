class spacewalk::server (
  $manage_repos        = $spacewalk::params::manage_repos,
  $repo_stage          = $spacewalk::params::repo_stage,
  $db_backend          = $spacewalk::params::db_backend,
  $package_list        = $spacewalk::params::package_list,
  $admin_email         = $spacewalk::params::admin_email,
  $ssl_set_city        = $spacewalk::params::ssl_set_city,
  $ssl_set_org         = $spacewalk::params::ssl_set_org,
  $ssl_set_org_unit    = $spacewalk::params::ssl_set_org_unit,
  $ssl_set_state       = $spacewalk::params::ssl_set_state,
  $ssl_set_country     = $spacewalk::params::ssl_set_country,
  $ssl_password        = $spacewalk::params::ssl_password,
  $ssl_set_email       = $spacewalk::params::ssl_set_email,
  $ssl_config_sslvhost = $spacewalk::params::ssl_config_sslvhost,
  $db_password         = $spacewalk::params::db_password,
  $db_port             = $spacewalk::params::db_port,
) inherits spacewalk::params {

  validate_bool($manage_repos)
  if ($manage_repos) {
    if !(defined(Stage[$repo_stage])) {
      stage { $repo_stage: before => Stage['main'] }
    }

    class { 'spacewalk::server::repos':
      stage => $repo_stage,
    }
  }
  validate_array($package_list)
  validate_re($db_port, '^\d+$')

  include spacewalk::server::packages
  include spacewalk::server::setup
  include spacewalk::server::service

  Class['spacewalk::server::packages']
  ~>
  Class['spacewalk::server::setup']
  ~>
  Class['spacewalk::server::service']
}
