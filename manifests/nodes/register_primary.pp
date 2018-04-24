class postgres_repmgr::nodes::register_primary{
    $check_cluster_status = "${::postgres_repmgr::pg_bindir}/repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf cluster show 2>/dev/null"
    $register_cmd = "repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf pirmary register"
    notify {"register_primary_cmd":
      message => "Using register_cmd: ${register_cmd}"
    }
    exec { 'register_primary':
      path => "${::postgres_repmgr::pg_bindir}/bin:/bin:/sbin:/usr/bin:/usr/sbin",
      command => $register_cmd,
      user    => 'postgres',
      unless => $check_cluster_status, #only execute when no cluster status,
    }
}
