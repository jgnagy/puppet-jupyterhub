# defaults follow the default jupyterhub config
class jupyterhub::params {
  $user                           = 'jupyterhub'
  $group                          = 'jupyterhub'
  $uid                            = '504'
  $gid                            = '504'
  $service                        = 'jupyterhub'
  $confdir                        = '/etc/jupyterhub'
  $manage_service                 = true
  $manage_sudo                    = true
  $ssl_key                        = undef
  $ssl_cert                       = undef
  $virtualenv                     = 'jupyterhub_env'
  $log_datefmt                    = undef
  $log_format                     = undef
  $log_level                      = '30'
  $jh_admin_access                = false
  $jh_answer_yes                  = false
  $jh_authenticator_class         = undef
  $jh_base_url                    = '/'
  $jh_api_tokens                  = undef
  $jh_cleanup_proxy               = undef
  $jh_cleanup_servers             = undef
  $jh_config_file                 = 'jupyterhub_config.py'
  $jh_confirm_no_ssl              = false
  $jh_cookie_max_age_days         = undef
  $jh_cookie_secret               = undef
  $jh_cookie_secret_file          = undef
  $jh_data_files_path             = undef
  $jh_db_kwargs                   = undef
  $jh_db_url                      = undef
  $jh_debug_db                    = false
  $jh_debug_proxy                 = false
  $jh_extra_log_file              = '/var/log/jupyterhub.log'
  $jh_extra_log_handlers          = undef
  $jh_hub_ip                      = '127.0.0.1'
  $jh_hub_port                    = '8081'
  $jh_hub_prefix                  = '/hub/'
  $jh_ip                          = $::ipaddress
  $jh_jinja_ev_options            = undef
  $jh_last_activity_interval      = undef
  $jh_logo_file                   = undef
  $jh_pid_file                    = '/var/run/jupyterhub/jupyterhub.pid'
  $jh_port                        = '8000'
  $jh_proxy_api_ip                = '127.0.0.1'
  $jh_proxy_api_port              = undef
  $jh_proxy_auth_token            = undef
  $jh_proxy_check_interval        = undef
  $jh_proxy_cmd                   = undef
  $jh_reset_db                    = false
  $jh_spawner_class               = 'sudospawner.SudoSpawner'
  $jh_statsd_host                 = undef
  $jh_statsd_prefix               = undef
  $jh_subdomain_host              = undef
  $jh_template_paths              = undef
  $jh_tornado_settings            = undef
  $spawner_args                   = undef
  $spawner_cmd                    = undef
  $spawner_debug                  = false
  $spawner_default_url            = undef
  $spawner_disable_user_config    = false
  $spawner_env_keep               = undef
  $spawner_environment            = undef
  $spawner_http_timeout           = undef
  $spawner_ip                     = '127.0.0.1'
  $spawner_notebook_dir           = undef
  $spawner_poll_interval          = '30'
  $spawner_start_timeout          = '60'
  $authenticator_admin_users      = undef
  $authenticator_username_map     = undef
  $authenticator_username_pattern = undef
  $authenticator_whitelist        = undef
  $local_auth_add_user_cmd        = undef
  $local_auth_create_users        = false
  $local_auth_group_whitelist     = undef
  $pam_auth_encoding              = 'utf8'
  $pam_auth_open_sessions         = undef
  $pam_auth_service               = undef
  case $::operatingsystem {
    'Ubuntu': {
      if $::operatingsystemmajrelease <= '14.04' {
        $servicefile      = '/etc/init.d/jupyterhub'
        $service_template = 'jupyterhub.init.erb'
      }
      else {
        $servicefile = '/lib/systemd/system/jupyterhub.service'
        $service_template = 'jupyterhub.service.erb'
      }
    }
    default: {
      fail("Unsupported platform: ${::osfamily} ${::operatingsystem} ${::kernelrelease}")
    }
  }
}
