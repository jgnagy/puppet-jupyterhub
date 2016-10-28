require 'spec_helper'
describe 'jupyterhub::config' do

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'it should create the config' do
          let(:pre_condition) do
            "class {'::jupyterhub':
               confdir => '/etc/jupyterhub',
               user    => 'jupyterhub',
               group   => 'jupyterhub',
               }"
          end
          it do
            is_expected.to contain_file('/etc/jupyterhub').with(
              'ensure' => 'directory',
              'owner'   => 'jupyterhub',
              'group'  => 'jupyterhub'
            )
          end
          it do
            is_expected.to contain_file('/etc/jupyterhub/jupyterhub_config.py').with(
              'ensure' => 'present',
              'owner'  => "jupyterhub",
              ).that_requires('File[/etc/jupyterhub]')
          end
        end

      end
    end
  end
end
