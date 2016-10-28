class jupyterhub::service (
  $user             = $jupyterhub::user,
  $service          = $jupyterhub::service,
  $servicefile      = $jupyterhub::servicefile,
  $service_template = $jupyterhub::service_template,
  $confdir          = $jupyterhub::confdir,
  $manage_service   = $jupyterhub::manage_service,
  )
{

  if $manage_service == true {
    file {$servicefile:
      ensure  => present,
      content => template("jupyterhub/${service_template}"),
      owner   => 'root',
      group   => 'root',
      mode    => '0751'
    }

    service {$service:
      ensure     => running,
      enable     => true,
      hasrestart => true,
    }
  }
}
