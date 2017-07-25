require 'beaker-rspec'
require 'beaker/puppet_install_helper'

logger.error("TSE Control Repo Spec Acceptance Helper")

# Install Puppet on all hosts
RSpec.configure do |c|
  control_repo_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
  # Install control repo on puppet master
    run_puppet_install_helper
    on master, 'rm -rf /etc/puppetlabs/code/environments/production'
    scp_to(master, control_repo_root, '/etc/puppetlabs/code/environments/production', opts = {})
    on master, 'cd /etc/puppetlabs/code/environments/production/; r10k puppetfile install'

    hosts.each do |host|
      # Add more setup code as needed
    end
  end
end
