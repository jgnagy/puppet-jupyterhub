# install pre-reqs and jupyter hub itself
class jupyterhub::install (
  $user             = $::jupyterhub::user,
  $group            = $::jupyterhub::group,
  $uid              = $::jupyterhub::uid,
  $gid              = $::jupyterhub::gid,
  $virtualenv       = $::jupyterhub::virtualenv,
  $manage_sudo      = $::jupyterhub::manage_sudo,
  $jh_spawner_class = $::jupyterhub::jh_spawner_class
  )
inherits jupyterhub::params
{
  $virtenv_dir = "/opt/${user}"
  # create the service account user

  group {$user:
    ensure => present,
    gid    => $gid,
  }

  user { $user:
    ensure     => present,
    comment    => 'service account for jupyterhub',
    home       => '/opt/jupyterhub',
    system     => true,
    managehome => true,
    uid        => $uid,
    gid        => $gid,
    require    => Group[$user],
  }

  # install nodejs and npm TODO: make sure this is in the puppet file
  include nodejs

  package {'configurable-http-proxy':
    ensure   => 'present',
    provider => 'npm',
    require  => Class['nodejs']
  }

  if ! defined(Package['git']) {
    package { 'git':
      ensure => installed,
    }
  }

  class { 'python' :
    pip        => 'present',
    virtualenv => 'present',
    dev        => 'present',
  }

  # setup virtualenv for jupyterhub to run in
  python::virtualenv {$virtualenv:
    ensure   => present,
    owner    => $user,
    group    => $group,
    version  => '3.4',
    venv_dir => "/opt/${user}/${virtualenv}",
    before   => Exec['install_sudospawner']
  }

  python::pip {'jupyterhub':
    virtualenv => "/opt/${user}/${virtualenv}",
    owner      => $user,
    group      => $group,
    pkgname    => 'jupyterhub',
  }

  python::pip {'notebook':
    virtualenv   => "/opt/${user}/${virtualenv}",
    owner        => $user,
    group        => $group,
    pkgname      => 'notebook',
    install_args => '--upgrade',
  }

  exec { 'install_sudospawner':
    command => "/opt/${user}/${virtualenv}/bin/pip install git+https://github.com/jupyter/sudospawner",
    creates => "/opt/${user}/${virtualenv}/bin/sudospawner",
    cwd     => "/opt/${user}/${virtualenv}/bin",
    user    => $user,
    require => Package['git']
  }

  if (($jh_spawner_class == 'sudospawner.SudoSpawner') and ($manage_sudo == true)) {
      sudo::conf {'jupyterhub':
        priority => 10,
        content  => template('jupyterhub/sudo.erb')
      }
  }
}
