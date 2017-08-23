class profile::platform::baseline::linux::ssh (
  String $permit_root_login = 'yes',
) {

  if !defined(Class['ssh::server']) and !defined(Class['demo_cis']) {
    class{'::ssh::server':
      permit_root_login       => $permit_root_login,
      password_authentication => 'yes',
      use_pam                 => 'yes',
    }
  }

  firewall { '100 ssh allow all':
    dport  => '22',
    chain  => 'INPUT',
    proto  => 'tcp',
    action => 'accept',
  }

}
