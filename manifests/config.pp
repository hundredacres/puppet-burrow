# = Class: burrow::config
#
# == Author
#   Matthew Schmitt <matthew.schmitt@riskiq.net/>
#
class burrow::config (
  $logdir              = $::burrow::params::logdir,
  $logconfig           = $::burrow::params::logconfig,
  $pidfile             = $::burrow::params::pidfile,
  $client_id           = $::burrow::params::client_id,
  $group_blacklist     = $::burrow::params::group_blacklist,
  $zookeeper_host      = $::burrow::params::zookeeper_host,
  $zookeeper_port      = $::burrow::params::zookeeper_port,
  $zookeeper_timeout   = $::burrow::params::zookeeper_timeout,
  $zookeeper_lock_path = $::burrow::params::zookeeper_lock_path,
  $service_restart     = $::burrow::params::service_restart,
  $httpserver          = $::burrow::params::httpserver,
  $smtpserver          = $::burrow::params::smtpserver,
  $httpnotifier        = $::burrow::params::httpnotifier,
) {

  #$server_config = deep_merge($burrow::params::burrow_config_defaults, $burrow::params::burrow_config)

  $config_notify = $service_restart ? {
    false   => undef,
    default => Service[$::burrow::service_name],
  }

  file { '/etc/burrow/config/burrow.toml':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('burrow/burrow.toml.erb'),
    notify  => $config_notify,
  }
}
