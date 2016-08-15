# == Class burrow::install
#
# This class is called from burrow for install.
#
class burrow::install {

  package { $::burrow::package_name:
    ensure => present,
  }
}
