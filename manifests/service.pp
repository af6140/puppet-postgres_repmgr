class postgres_repmgr::service {
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
  service {$::postgres_repmgr::repmgr_service_name:
    ensure => 'running',
    enable => true,
  }
}
