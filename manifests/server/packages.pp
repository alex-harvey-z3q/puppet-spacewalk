class spacewalk::server::packages (
  $db_backend   = $spacewalk::server::db_backend,
  $package_list = $spacewalk::server::package_list,
){
  case $db_backend {
    postgresql: {
      package { $package_list: ensure => installed }
    }
    oracle: {
      fail('Not implemented, please raise a feature request')
    }
    default: {
      fail('Supported backends are: postgresql')
    }
  }
}
