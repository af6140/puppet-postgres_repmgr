class postgres_repmgr::nodes::clone_primary{
    $check_cluster_status = "${::postgres_repmgr::conf_dir}/repmgr.conf cluster show 2>/dev/null"
    exec { 'stop_postgresql':
      user    => 'postgres',
      command => $postgres_repmgr::service_stop_cmd,
      only_if => $postgres_repmgr::service_status_cmd,
    } ->
    exec { 'clone_standby':
      path => "${::postgres_repmgr::pg_bindir}/bin:/bin:/sbin:/usr/bin:/usr/sbin",
      command => "repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf -c -R repmgr standby clone",
      user    => 'postgres',
    }
}
