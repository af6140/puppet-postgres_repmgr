class postgres_repmgr::nodes::register_standby{

    ## To Do: Fix logic when to register
    # Do not use for now.
    #$check_cluster_status = "${::postgres_repmgr::pg_bindir}/repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf cluster show 2>/dev/null"

    $register_cmd = "${::postgres_repmgr::pg_bindir}/repmgr -f ${::postgres_repmgr::conf_dir}/repmgr.conf standby register"
    notify {"register_standby_cmd":
      message => "Registering standby using register_cmd: ${register_cmd}"
    }
    exec { 'register_standby':
      command => $register_standby_cmd,
      user    => 'postgres',
      tries => 5,
      try_sleep => 5,
      unless => $check_cluster_status, #only execute when no cluster status
    }
}
