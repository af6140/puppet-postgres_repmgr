# Class: postgres_repmgr
# ===========================
#
# Full description of class postgres_repmgr here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'postgres_repmgr':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class postgres_repmgr(
  String[1] $package_version=$::postgres_repmgr::params::package_version,
  Enum['manual','automatic'] $failover= $::postgres_repmgr::params::failover,
  String[1] $log_dir = $::postgres_repmgr::params::log_dir,
  String[2] $pg_version = $::postgres_repmgr::params::pg_version,
  String[1] $node_id,
  Integer $node_priority = 100,
  String[3] $node_name = $::fqdn,
  String[1] $repmgr_db_user= $::postgres_repmgr::params::repmgr_db_user,
  String[1] $repmgr_db_pass = $::postgres_repmgr::params::repmgr_db_pass,
  String[1] $repmgr_db_name= $::postgres_repmgr::params::repmgr_db_name,
  Optional[String[1]] $pg_basebackup_options= $postgres_repmgr::params::pg_basebackup_options,
  String[1] $pg_passfile = $postgres_repmgr::params::pg_passfile,
  String[1] $primary_node,
  String[1] $remote_user = $postgres_repmgr::params::remote_user,
  Optional[String[1]] $ssh_public_key_path = undef,
) inherits postgres_repmgr::params {


  $version_int = regsubst($pg_version, '\D+', '\1', 'G')
  $package_name = "repmgr${version_int}"
  $service_name = "postgresql-${pg_version}"
  $repmgr_service_name = "repmgr${version_int}"
  $pg_service_name = "postgresql-${pg_version}"
  $service_start_cmd = "sudo systemctl start ${service_name}"
  $service_stop_cmd = "sudo systemctl stop ${service_name}"
  $service_restart_cmd = "sudo systemctl restart ${service_name}"
  $service_reload_cmd = "sudo systemctl reload ${service_name}"
  $service_status_cmd = "sudo systemctl status ${service_name}"
  $conf_dir = "/etc/repmgr/${pg_version}"


  $pg_bindir = "/usr/pgsql-${pg_version}/bin"
  $pg_datadir = "/var/lib/pgsql/${pg_version}/data"


  # postgresql_conn_validator { 'validate my postgres connection':
  #   host              =>  '127.0.0.1',
  #   db_username       => $::postgres_repmgr::repmgr_db_user,
  #   db_password       => $::postgres_repmgr::repmgr_db_pass,
  #   db_name           => $::postgres_repmgr::repmgr_db_name,
  # }->

  postgresql::validate_db_connection { 'validate_repmgr_db_connection':
    database_host           => '127.0.0.1',
    database_username       => $::postgres_repmgr::repmgr_db_user,
    database_password       => $::postgres_repmgr::repmgr_db_pass,
    database_name           => $::postgres_repmgr::repmgr_db_name,
  }->
  class {'postgres_repmgr::install':
  } ->
  class {'postgres_repmgr::config':
  } ->
  class {'postgres_repmgr::service':
  }

  contain 'postgres_repmgr::install'
  contain 'postgres_repmgr::config'
  contain 'postgres_repmgr::service'
}
