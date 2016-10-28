require 'spec_helper'
describe 'jupyterhub::install' do

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        let(:pre_condition) do
          "class {'::jupyterhub':
             confdir          => '/etc/jupyterhub',
             user             => 'jupyterhub',
             group            => 'jupyterhub',
             manage_sudo      => true,
             jh_spawner_class => 'sudospawner.SudoSpawner'
             }"
        end
        context 'it should create the group' do
          it do
            is_expected.to contain_group('jupyterhub').with(
              'gid' => '504'
            )
          end
        end
        context 'it should create the user' do
          it do
            is_expected.to contain_user('jupyterhub').with(
              'ensure'     => 'present',
              'comment'    => 'service account for jupyterhub',
              'home'       => '/opt/jupyterhub',
              'system'     => true,
              'managehome' => true,
              'uid'        => '504',
              'gid'        => '504',
            ).that_requires('Group[jupyterhub]')
          end
        end
        context 'it should contain nodejs' do
          it { is_expected.to contain_class('nodejs')}
        end
        context 'it should install configurable-http-proxy' do
          it do
            is_expected.to contain_package('configurable-http-proxy').with(
              'provider' => 'npm',
            ).that_requires('Class[nodejs]')
          end
        end
        context 'it should install git if not defined elsewhere' do
          it do
            is_expected.to contain_package('git')
          end
        end
        context 'it should create the python virtual env' do
          it do
            is_expected.to contain_python__virtualenv('jupyterhub_env').with(
              'ensure'   => 'present',
              'owner'    => 'jupyterhub',
              'group'    => 'jupyterhub',
              'version'  => '3.4',
              'venv_dir' => '/opt/jupyterhub/jupyterhub_env'
            )
          end
        end
        context 'it should install pip packages' do
          it do
            is_expected.to contain_python__pip('jupyterhub').with(
              'virtualenv' => '/opt/jupyterhub/jupyterhub_env',
              'owner'      => 'jupyterhub',
              'group'      => 'jupyterhub',
              'pkgname'    => 'jupyterhub'
            )
          end
          it do
            is_expected.to contain_python__pip('notebook').with(
              'virtualenv'   => '/opt/jupyterhub/jupyterhub_env',
              'owner'        => 'jupyterhub',
              'group'        => 'jupyterhub',
              'pkgname'      => 'notebook',
              'install_args' => '--upgrade'
            )
          end
        end
        context 'it should install the sudospawner pkg' do
          it do
            is_expected.to contain_exec('install_sudospawner').with(
              'command' => '/opt/jupyterhub/jupyterhub_env/bin/pip install git+https://github.com/jupyter/sudospawner',
              'creates' => '/opt/jupyterhub/jupyterhub_env/bin/sudospawner',
              'cwd'     => '/opt/jupyterhub/jupyterhub_env/bin',
              'user'    => 'jupyterhub',
            ).that_requires('Package[git]')
          end
        end
        context 'should manage sudo if sudo spawner is used' do
          it do
            is_expected.to contain_sudo__conf('jupyterhub')
          end
        end
      end
    end
    context 'supported operating systems' do
      on_supported_os.each do |os, facts|
        context "on #{os}" do
          let(:facts) do
            facts
          end
          let(:pre_condition) do
            "class {'::jupyterhub':
               confdir          => '/etc/jupyterhub',
               user             => 'jupyterhub',
               group            => 'jupyterhub',
               manage_sudo      => false,
               }"
          end
          context 'should not manage sudo if set to false' do
            it do
              is_expected.not_to contain_sudo__conf('jupyterhub')
            end
          end
        end
      end
    end
  end
end
