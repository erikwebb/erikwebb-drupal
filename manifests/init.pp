# == Class: drupal
#
# Full description of class drupal here.
#
# === Parameters
#
# [*version*]
#   Specify a Drupal version to install. Defaults to the title of this defined
#   resource.
#
# [*path*]
#   Specify a path in which Drush will execute the command. Defaults to
#   "/var/www/html".
#
# [*uri*]
#   Specify a URI of the Drupal site to use. Defaults to "default".
#
# === Examples
#
#  class { drupal:
#    version => '7.21',
#  }
#
# === Authors
#
# Erik Webb <erik@erikwebb.net>
#
# === Copyright
#
# Copyright 2013 Erik Webb, unless otherwise noted.
#
class drupal {

  class { 'drush':
    version => '5.8.0',
  }

}
