# == Class burrow::service
#
# This class is meant to be called from burrow.
# It ensure the service is running.
#
class burrow::service {

  service { $::burrow::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$::burrow::package_name],
  }
}
