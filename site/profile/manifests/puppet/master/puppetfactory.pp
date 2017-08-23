class profile::puppet::master::puppetfactory {

  $plugin_list = [ 'Certificates','Docker','Logs','ShellUser']

  class { '::puppetfactory':
    plugins     => $plugin_list,
    controlrepo => 'control-repo.git',
    repomodel   => 'single',
    usersuffix  => 'puppetlabs.vm',
    session     => '12345',
    privileged  => true,
    master      => $::fqdn,
    allow_root  => 'yes',
  }

}
