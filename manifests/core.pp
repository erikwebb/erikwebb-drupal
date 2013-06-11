# == Define: drupal::core
#
# Install Drupal core.
#
# === Parameters
#
# [*version*]
#   Specify a Drupal version to install. Defaults to the title of this defined
#   resource.
#
# [*path*]
#   Specify a path prefix in which to install Drupal. Defaults to "/var/www".
#
# === Examples
#
# Install the latest version of Drupal core:
#
#   include drupal
#   drupal::core { '7.21':
#     path => '/var/www/html',
#   }
#
# === Authors
#
# Erik Webb <erik@erikwebb.net>
#
# === Copyright
#
# Copyright 2013 Erik Webb, unless otherwise noted.
#
define drupal::core(
  $version = 'latest',
  $path    = '/var/www/html',
) {

  if $version != 'latest' {
    $package = "drupal-${version}"
  } else {
    $package = "drupal"
  }

  $path_parts  = split($path, '/')
  $path_count  = size($path_parts)
  $path_prefix = join(values_at($path_parts, join([0, $path_count - 2], '-')), '/')
  $drupal_dir  = values_at($path_parts, "${path_count - 1}")

  drush::exec { 'drush-drupal-core-download':
    command => "pm-download ${package}",
    options => [ "--destination=${path_prefix}", "--drupal-project-rename=${drupal_dir}" ],
    # /var/www/html probably exists already, so farce an overwrite
    force   => $path == '/var/www/html',
  }

}
