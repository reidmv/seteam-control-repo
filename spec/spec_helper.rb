require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'simplecov'
require 'simplecov-console'

include RspecPuppetFacts

# Custom Facts
add_custom_fact :is_pe, 'true'
add_custom_fact :pe_version, nil
add_custom_fact :pe_server_version, '2017.2.1'
add_custom_fact :puppet_server, 'master.test.com'
add_custom_fact :servername, 'master.test.com'
add_custom_fact :fqdn, 'master.test.com'
add_custom_fact :networking, {'ip' => '127.0.0.1'}
add_custom_fact :memory, {
  "system" => {
    "used" => "7.37 GiB",
    "total" => "15.51 GiB",
    "capacity" => "47.48%",
    "available" => "8.15 GiB",
    "used_bytes" => 7910199296,
    "total_bytes" => 16658804736,
    "available_bytes" => 8748605440
  }
}


if !Gem.win_platform?
  add_custom_fact :staging_http_get,    'curl'
  add_custom_fact :ssh_version,         'OpenSSH_6.6.1p1'
  add_custom_fact :ssh_version_numeric, '6.6.1'
  add_custom_fact :gogs_version,        '0.11.19'
else
  add_custom_fact :choco_install_path,  'C:\ProgramData\chocolatey'
  add_custom_fact :chocolateyversion,   '0.10.7'
  add_custom_fact :archive_windir,      'C:\ProgramData\staging'
  add_custom_fact :staging_windir,      'C:\ProgramData\staging'
  add_custom_fact :operatingsystemversion, 'Windows Server 2012 R2 Standard'
  add_custom_fact :staging_http_get,     'powershell'
end


supported_os = on_supported_os.keys
if Gem.win_platform?
  SUPPORTED_OS = on_supported_os.delete_if { |k,v| !k.to_s.match(/windows/i) }
else
  SUPPORTED_OS = on_supported_os.delete_if { |k,v| k.to_s.match(/windows/i) }
end
puts "WARNING: Ommiting the following supported OS from this test run: #{(supported_os - SUPPORTED_OS.keys).join(',')}"

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ])
end

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation
  c.color     = true
end



