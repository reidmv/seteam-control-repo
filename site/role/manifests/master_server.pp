class role::master_server {
  include ::profile::puppet::master
  include ::profile::platform::baseline
}
