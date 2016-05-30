class spacewalk::params {

  unless $::osfamily == 'RedHat' {
    fail("module not supported for OSfamily ${::osfamily}")
  }
  unless ($::operatingsystemmajrelease == '6') or
         ($::operatingsystemmajrelease == '7') {
    fail("module not supported for operatingsystemmajrelease ${::operatingsystemmajrelease}")
  }

  $manage_repos        = false
  $repo_stage          = 'pre'
  $db_backend          = 'postgresql'
  $package_list        = [
    'spacewalk-setup-postgresql',
    'spacewalk-postgresql',
  ]
  $admin_email         = 'root@localhost'
  $ssl_set_org         = 'Spacewalk Org'
  $ssl_set_org_unit    = 'spacewalk'
  $ssl_set_city        = 'My City'
  $ssl_set_state       = 'My State'
  $ssl_set_country     = 'AU'
  $ssl_password        = 'spacewalk'
  $ssl_set_email       = 'root@localhost'
  $ssl_config_sslvhost = 'Y'
  $db_password         = 'spacewalk'
  $db_port	       = '5432'

  $yumrepos = {
    'spacewalk' => {
      baseurl  => "http://yum.spacewalkproject.org/2.4/RHEL/${::operatingsystemmajrelease}/\$basearch/",
      descr    => 'Spacewalk',
      enabled  => '1',
      gpgcheck => '1',
      gpgkey   => 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015',
    },
    'spacewalk-nightly' => {
      baseurl  => "http://yum.spacewalkproject.org/nightly/RHEL/${::operatingsystemmajrelease}/\$basearch/",
      descr    => 'Spacewalk nightly',
      enabled  => '0',
      gpgcheck => '0',
      gpgkey   => 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015',
    },
    'spacewalk-source' => {
      baseurl  => "http://yum.spacewalkproject.org/2.4/RHEL/${::operatingsystemmajrelease}/source/",
      descr    => 'Spacewalk SRPMS',
      enabled  => '0',
      gpgcheck => '1',
      gpgkey   => 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015',
    },
    'jpackage-generic' => {
      descr      => 'JPackage generic',
      enabled    => '1',
      gpgcheck   => '1',
      gpgkey     => 'http://www.jpackage.org/jpackage.asc',
      mirrorlist => 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0',
    },
    'epel' => {
      descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease} - \$basearch",
      enabled        => '1',
      failovermethod => 'priority',
      gpgcheck       => '1',
      gpgkey         => 'https://getfedora.org/static/352C64E5.txt',
      mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch',
    },
    'epel-debuginfo' => {
      descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease} - \$basearch - Debug",
      enabled        => '0',
      failovermethod => 'priority',
      gpgcheck       => '1',
      gpgkey         => 'https://getfedora.org/static/352C64E5.txt',
      mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=$basearch',
    },
    'epel-source' => {
      descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease} - \$basearch - Source",
      enabled        => '0',
      failovermethod => 'priority',
      gpgcheck       => '1',
      gpgkey         => 'https://getfedora.org/static/352C64E5.txt',
      mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-source-7&arch=$basearch',
    },
    'epel-testing' => {
      descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease} - Testing - \$basearch",
      enabled        => '0',
      failovermethod => 'priority',
      gpgcheck       => '1',
      gpgkey         => 'https://getfedora.org/static/352C64E5.txt',
      mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=testing-epel7&arch=$basearch',
    },
    'epel-testing-debuginfo' => {
      descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease} - Testing - \$basearch - Debug",
      enabled        => '0',
      failovermethod => 'priority',
      gpgcheck       => '1',
      gpgkey         => 'https://getfedora.org/static/352C64E5.txt',
      mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=testing-debug-epel7&arch=$basearch',
    },
    'epel-testing-source' => {
      descr          => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease} - Testing - \$basearch - Source",
      enabled        => '0',
      failovermethod => 'priority',
      gpgcheck       => '1',
      gpgkey         => 'https://getfedora.org/static/352C64E5.txt',
      mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=testing-source-epel7&arch=$basearch',
    }
  }
}
