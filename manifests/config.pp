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
    content => template('postgres_repmgr/repmgr.conf.erb'),
    notify => Service[$::postgres_repmgr::repmgr_service_name],
    require => Package[$::postgres_repmgr::package_name],
  }
  file {$::postgres_repmgr::pg_passfile:
    ensure=> 'present',
    mode => '0600',
    owner => 'postgres',
    group => 'postgres',
    content => "*:*:${::postgres_repmgr::repmgr_db_name}:${::postgres_repmgr::repmgr_db_user}:${::postgres_repmgr::repmgr_db_pass}"
  }

  if $postgres_repmgr::primary_node == $::fqdn {
    notify {"node ${::postgres_repmgr::primary_node} is primary node ":
    }->
    class{'postgres_repmgr::nodes::register_primary':
      require => File["${::postgres_repmgr::conf_dir}/repmgr.conf"]
    }
  }
}
