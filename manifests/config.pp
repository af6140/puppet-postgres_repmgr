class postgres_repmgr::config (
  $pg_host = '127.0.0.1'
)inherits postgres_repmgr {

  file { $::postgres_repmgr::conf_dir:
    ensure => 'directory',
    mode => '0755',
  } ->
  file { "${::postgres_repmgr::conf_dir}/repmgr.conf":
    ensure => 'present',
    mode => '0600',
    owner => 'postgres',
    group => 'postgres',
    content => template('postgres_repmgr/repmgr.conf.erb')
  }

  file {$::postgres_repmgr::pg_passfile:
    ensure=> 'present',
    mode => '0600',
    owner => 'postgres',
    group => 'postgres',
    content => "${::postgres_repmgr::repmgr_db_name}:${::postgres_repmgr::repmgr_db_user};${::postgres_repmgr::repmgr_db_pass}}"
  }
}
