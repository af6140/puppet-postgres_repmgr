class postgres_repmgr::nodes::register_standby{
    $check_cluster_status = "${::postgres_repmgr::conf_dir}/repmgr.conf cluster show 2>/dev/null"
    exec { 'register_standby':
      path => "${::postgres_repmgr::pg_bindir}/bin:/bin:/sbin:/usr/bin:/usr/sbin",
      command => "repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf standby register",
      user    => 'postgres',
      unless => $check_cluster_status, #only execute when no cluster status
    }
}
