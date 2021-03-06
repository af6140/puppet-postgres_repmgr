class postgres_repmgr::install {

  package{$::postgres_repmgr::package_name:
    ensure => $::postgres_repmgr::package_version
  } ->
  file { $::postgres_repmgr::log_dir:
    ensure => 'directory'
  } ->
  file { "${postgres_repmgr::pg_bindir}/repmgr" :
    ensure  => 'present',
    replace => 'no', # this is the important property
    content => "From Puppet\n",
    mode    => '4774',
    owner => 'postgres',
    group  => 'postgres',
  }
}
