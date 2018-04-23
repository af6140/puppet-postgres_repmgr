class postgres_repmgr::install {

  package{$::postgres_repmgr::package_name:
    ensure => $::postgres_repmgr::package_version
  } ->
  file { $::postgres_repmgr::log_dir:
    ensure => 'directory'
  }
}
