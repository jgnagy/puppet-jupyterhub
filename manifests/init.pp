# == Class: jupyterhub
#
# Full description of class jupyterhub here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'jupyterhub':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class jupyterhub
  (
    $user                           = $jupyterhub::params::user,
    $group                          = $jupyterhub::params::group,
    $virtualenv                     = $jupyterhub::params::virtualenv,
    $ssl_key                        = $jupyterhub::params::ssl_key,
    $ssl_cert                       = $jupyterhub::params::ssl_cert,
    $service                        = $jupyterhub::params::service,
    $servicefile                    = $jupyterhub::params::servicefile,
    $service_template               = $jupyterhub::params::service_template,
    $manage_service                 = $jupyterhub::params::manage_service,
    $manage_sudo                    = $jupyterhub::params::manage_sudo,
    $confdir                        = $jupyterhub::params::confdir,
    $log_format                     = $jupyterhub::params::log_format,
    $log_level                      = $jupyterhub::params::log_level,
    $jh_admin_access                = $jupyterhub::params::jh_admin_access,
    $jh_answer_yes                  = $jupyterhub::params::jh_answer_yes,
    $jh_authenticator_class         = $jupyterhub::params::jh_authenticator_class,
    $jh_base_url                    = $jupyterhub::params::jh_base_url,
    $jh_api_tokens                  = $jupyterhub::params::jh_api_tokens,
    $jh_cleanup_proxy               = $jupyterhub::params::jh_cleanup_proxy,
    $jh_cleanup_servers             = $jupyterhub::params::jh_cleanup_servers,
    $jh_config_file                 = $jupyterhub::params::jh_config_file,
    $jh_confirm_no_ssl              = $jupyterhub::params::jh_confirm_no_ssl,
    $jh_cookie_max_age_days         = $jupyterhub::params::jh_cookie_max_age_days,
    $jh_cookie_secret               = $jupyterhub::params::jh_cookie_secret,
    $jh_cookie_secret_file          = $jupyterhub::params::jh_cookie_secret_file,
    $jh_data_files_path             = $jupyterhub::params::jh_data_files_path,
    $jh_db_kwargs                   = $jupyterhub::params::jh_db_kwargs,
    $jh_db_url                      = $jupyterhub::params::jh_db_url,
    $jh_debug_db                    = $jupyterhub::params::jh_debug_db,
    $jh_debug_proxy                 = $jupyterhub::params::jh_debug_proxy,
    $jh_extra_log_file              = $jupyterhub::params::jh_extra_log_file,
    $jh_extra_log_handlers          = $jupyterhub::params::jh_extra_log_handlers,
    $jh_hub_ip                      = $jupyterhub::params::jh_hub_ip,
    $jh_hub_port                    = $jupyterhub::params::jh_hub_port,
    $jh_hub_prefix                  = $jupyterhub::params::jh_hub_prefix,
    $jh_ip                          = $jupyterhub::params::jh_ip,
    $jh_jinja_ev_options            = $jupyterhub::params::jh_jinja_ev_options,
    $jh_last_activity_interval      = $jupyterhub::params::jh_last_activity_interval,
    $jh_logo_file                   = $jupyterhub::params::jh_logo_file,
    $jh_pid_file                    = $jupyterhub::params::jh_pid_file,
    $jh_port                        = $jupyterhub::params::jh_port,
    $jh_proxy_api_ip                = $jupyterhub::params::jh_proxy_api_ip,
    $jh_proxy_api_port              = $jupyterhub::params::jh_proxy_api_port,
    $jh_proxy_auth_token            = $jupyterhub::params::jh_proxy_auth_token,
    $jh_proxy_check_interval        = $jupyterhub::params::jh_proxy_check_interval,
    $jh_proxy_cmd                   = $jupyterhub::params::jh_proxy_cmd,
    $jh_reset_db                    = $jupyterhub::params::jh_reset_db,
    $jh_spawner_class               = $jupyterhub::params::jh_spawner_class,
    $jh_statsd_host                 = $jupyterhub::params::jh_statsd_host,
    $jh_statsd_prefix               = $jupyterhub::params::jh_statsd_prefix,
    $jh_subdomain_host              = $jupyterhub::params::jh_subdomain_host,
    $jh_template_paths              = $jupyterhub::params::jh_template_paths,
    $jh_tornado_settings            = $jupyterhub::params::jh_tornado_settings,
    $spawner_args                   = $jupyterhub::params::spawner_args,
    $spawner_cmd                    = $jupyterhub::params::spawner_cmd,
    $spawner_debug                  = $jupyterhub::params::spawner_debug,
    $spawner_default_url            = $jupyterhub::params::spawner_default_url,
    $spawner_disable_user_config    = $jupyterhub::params::spawner_disable_user_config,
    $spawner_env_keep               = $jupyterhub::params::spawner_env_keep,
    $spawner_environment            = $jupyterhub::params::spawner_environment,
    $spawner_http_timeout           = $jupyterhub::params::spawner_http_timeout,
    $spawner_ip                     = $jupyterhub::params::spawner_ip,
    $spawner_notebook_dir           = $jupyterhub::params::spawner_notebook_dir,
    $spawner_poll_interval          = $jupyterhub::params::spawner_poll_interval,
    $spawner_start_timeout          = $jupyterhub::params::spawner_start_timeout,
    $authenticator_admin_users      = $jupyterhub::params::authenticator_admin_users,
    $authenticator_username_map     = $jupyterhub::params::authenticator_username_map,
    $authenticator_username_pattern = $jupyterhub::params::authenticator_username_pattern,
    $authenticator_whitelist        = $jupyterhub::params::authenticator_whitelist,
    $local_auth_add_user_cmd        = $jupyterhub::params::local_auth_add_user_cmd,
    $local_auth_create_users        = $jupyterhub::params::local_auth_create_users,
    $local_auth_group_whitelist     = $jupyterhub::params::local_auth_group_whitelist,
    $pam_auth_encoding              = $jupyterhub::params::pam_auth_encoding,
    $pam_auth_open_sessions         = $jupyterhub::params::pam_auth_open_sessions,
    $pam_auth_service               = $jupyterhub::params::pam_auth_service,
    )

  inherits ::jupyterhub::params
{

  class {'::jupyterhub::install':}
  ->
  class {'::jupyterhub::config':}
  ~>
  class {'::jupyterhub::service':}
}
