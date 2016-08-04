# = Class: burrow
#
# == Author
#   Matthew Schmitt <matthew.schmitt@riskiq.net/>
#
class burrow(
  $logdir              = $burrow::params::logdir,
  $logconfig           = $burrow::params::logconfig,
  $pidfile             = $burrow::params::pidfile,
  $client_id           = $burrow::params::client_id,
  $zookeeper_host      = $burrow::params::zookeeper_host,
  $zookeeper_port      = $burrow::params::zookeeper_port,
  $zookeeper_timeout   = $burrow::params::zookeeper_timeout,
  $zookeeper_lock_path = $burrow::params::zookeeper_lock_path,
  $kafka_cluster       = $burrow::params::kafka_cluster,
  $storm_cluster       = $burrow::params::storm_cluster,
  $service_restart     = $burrow::params::service_restart,
  $httpserver          = $burrow::params::httpserver,
  $smtpserver          = $burrow::params::smtpserver,
  $httpnotifier        = $burrow::params::httpnotifier,
  $debug               = $burrow::params::debug,
){
  validate_array($zookeeper_host)
  validate_hash($kafka_cluster,$storm_cluster)
  #### Ordering
  class{'burrow::install': } ->
  class{'burrow::config': } ->
  class{'burrow::service': } ->
  Class['burrow']

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
