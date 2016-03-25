class spacewalk::firewall (
  $firewall_source      = $::spacewalk::params::firewall_source,
  $firewall_http_order  = $::spacewalk::params::firewall_http_order,
  $firewall_https_order = $::spacewalk::params::firewall_https_order,
) {
  firewall { "${firewall_http_order} accept inbound http":
    source => $firewall_source,
    action => 'accept',
    proto  => 'tcp',
    dport  => 80,
  }
  firewall { "${firewall_https_order} accept inbound https":
    source => $firewall_source,
    action => 'accept',
    proto  => 'tcp',
    dport  => 443,
  }
}
