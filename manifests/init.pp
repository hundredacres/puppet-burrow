# Class: burrow
# ===========================
#
# Full description of class burrow here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class burrow (
  $package_name        = $::burrow::params::package_name,
  $service_name        = $::burrow::params::service_name,
  $logdir              = $::burrow::params::logdir,
  $logconfig           = $::burrow::params::logconfig,
  $pidfile             = $::burrow::params::pidfile,
  $client_id           = $::burrow::params::client_id,
  $zookeeper_host      = $::burrow::params::zookeeper_host,
  $zookeeper_port      = $::burrow::params::zookeeper_port,
  $zookeeper_timeout   = $::burrow::params::zookeeper_timeout,
  $zookeeper_lock_path = $::burrow::params::zookeeper_lock_path,
  $kafka_cluster       = $::burrow::params::kafka_cluster,
  $storm_cluster       = $::burrow::params::storm_cluster,
  $service_restart     = $::burrow::params::service_restart,
  $httpserver          = $::burrow::params::httpserver,
  $smtpserver          = $::burrow::params::smtpserver,
  $httpnotifier        = $::burrow::params::httpnotifier,
  $debug               = $::burrow::params::debug,
) inherits ::burrow::params {

  # validate parameters here

  class { '::burrow::install': } ->
  class { '::burrow::config': } ~>
  class { '::burrow::service': } ->
  Class['::burrow']

  #### Debugging
  # dump variable names and values (idea from A. Franceschi, http://j.mp/wBJRjo)
  $debug_vardump_ensure = $debug ? {
    true  => 'present',
    false => 'absent',
  }
  file { "debug_${module_name}_vardump":
    ensure  => $debug_vardump_ensure,
    path    => "${settings::vardir}/debug_${module_name}_vardump",
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    # do not forget to update the class documentation (-> 'debug' parameter) if
    # you change the .reject regex pattern
    content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.sort.map { |k,v| "#{k}: #{v.inspect}"}.join("\n") + "\n" %>'),
  }
}
