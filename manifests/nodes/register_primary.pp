class postgres_repmgr::nodes::register_primary{
    $check_cluster_status = "${::postgres_repmgr::pg_bindir}/repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf cluster show 2>/dev/null"
    $register_cmd = "${::postgres_repmgr::pg_bindir}/repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf pirmary register"
    notify {"register_primary_cmd":
      message => "Using register_cmd: ${register_cmd}"
    }
    exec { 'register_primary':
      command => $register_cmd,
      user    => 'postgres',
      unless => $check_cluster_status, #only execute when no cluster status,
    }
}
