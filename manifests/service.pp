class postgres_repmgr::service {
  service {$::postgres_repmgr::repmgr_service_name:
    ensure => 'running',
    enable => true,
  }
}
