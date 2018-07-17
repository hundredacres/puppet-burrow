# == Class burrow::params
#
# This class is meant to be called from burrow.
# It sets variables according to platform.
#
# == Author
#   Matthew Schmitt <matthew.schmitt@riskiq.net/>
#
class burrow::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'burrow'
      $service_name = 'burrow'
    }
    'RedHat', 'Amazon': {
      $package_name = 'burrow'
      $service_name = 'burrow'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $logdir              = '/var/log'
  $logconfig           = 'config/logging.cfg'
  $pidfile             = 'burrow.pid'
  $client_id           = 'burrow-lagchecker'
  $group_blacklist     = '^(console-consumer-|python-kafka-consumer-).*$'
  $zookeeper_host      = ['localhost']
  $zookeeper_port      = 2181
  $zookeeper_timeout   = 6
  $zookeeper_lock_path = '/burrow/notifier'
  $kafka_cluster       = {}
  $kafka_consumer      = {}
  $storm_cluster       = {}
  $service_restart     = true
  $httpserver          = true
  $smtpserver          = undef
  $httpnotifier        = undef
  $debug               = false
}
