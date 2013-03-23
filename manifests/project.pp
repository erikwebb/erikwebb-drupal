# == Define: drupal::project
#
# Install a single Drupal project.
#
# === Parameters
#
# [*project*]
#   Specify a Drupal project to install. Defaults to the title of this defined
#   resource.
#
# [*version*]
#   Specify a Drupal version to install..
#
# === Examples
#
# Install the Views module:
#
#   drush::project { 'views':
#     version = '7.x-3.6',
#   }
#
# Install the latest version of multiple modules:
#
#   $drupal_modules = ['ctools', 'views']
#   drupal::project { $drupal_modules: }
#
# === Authors
#
# Erik Webb <erik@erikwebb.net>
#
# === Copyright
#
# Copyright 2013 Erik Webb, unless otherwise noted.
#
define drupal::project(
  $project = $title,
  $version = 'latest',
  $path    = $drupal::path
) {

  if $version != 'latest' {
    $real_project = "${project}-${version}"
  } else {
    $real_project = "${project}"    
  }

  drush::exec { "drush-${real_project}-download":
    command        => "pm-download ${real_project}",
    root_directory => $path,
  }

  # Make sure all Drupal modules depend on their respective core
  Drupal::Core <| path == $path |> -> Drush::Exec["drush-${real_project}-download"]

}
