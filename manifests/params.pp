class postgres_repmgr::params {
  $pg_version = '9.6'
  $conf_dir = '/etc/repmgr'

  $package_version = 'present'
  $log_dir = '/var/log/repmgr'

  $failover = 'manual'

  $repmgr_db_user = 'repmgr'
  $repmgr_db_name = 'repmgr'
  $repmgr_db_pass = 'password'
  $repmgr_db_host = $::ipaddress

  $pg_basebackup_options = '-c' #faster but may afffect pg performance

  #https://repmgr.org/docs/4.0/cloning-advanced.html
  $pg_passfile = "/var/lib/pgsql/.pgpass"

  $remote_user = 'repmgr'

}
