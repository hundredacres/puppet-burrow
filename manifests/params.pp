class burrow::params {
  $logdir              = 'log'
  $logconfig           = 'config/logging.cfg'
  $pidfile             = 'burrow.pid'
  $client_id           = 'burrow-lagchecker'
  $group_blacklist     = '^(console-consumer-|python-kafka-consumer-).*$'
  $zookeeper_host      = []
  $zookeeper_port      = 2181
  $zookeeper_timeout   = 6
  $zookeeper_lock_path = '/burrow/notifier'
  $kafka_cluster       = undef
  $storm_cluster       = undef
  $service_restart     = true
  $httpserver          = true
  $smtpserver          = undef
  $httpnotifier        = undef
  $debug               = false
}
