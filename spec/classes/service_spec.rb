require 'spec_helper'
describe 'jupyterhub::service' do
  let(:pre_condition) do
    "class {'::jupyterhub':
       confdir => '/etc/jupyterhub',
       user    => 'jupyterhub',
       group   => 'jupyterhub',
       }"
  end
  context 'on Ubuntu 14' do
    let(:facts) do
      {
        :kernel => 'linux',
        :osfamily => 'Debian',
        :operatingsystem => 'Ubuntu',
        :operatingsystemrelease => '14.04',
        :operatingsystemmajrelease => '14.04',
        :lsbdistid => 'Ubuntu',
        :lsbdistrelease => '14.04',
        :lsbdistcodename => 'Trusty',
      }
    end
    describe 'it should create the init script' do
      it do
        is_expected.to contain_file('/etc/init.d/jupyterhub').with(
          'ensure' => 'present',
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0751'
        )
      end
      it do
        is_expected.to contain_service('jupyterhub').with(
          'ensure'     => 'running',
          'enable'     => true,
          'hasrestart' => true,
        )
      end
    end
  end
  context 'on Ubuntu 16' do
    let(:facts) do
      {
        :kernel => 'linux',
        :osfamily => 'Debian',
        :operatingsystem => 'Ubuntu',
        :operatingsystemrelease => '16.04',
        :operatingsystemmajrelease => '16.04',
        :lsbdistid => 'Ubuntu',
        :lsbdistrelease => '16.04',
        :lsbdistcodename => 'Xenial',
      }
    end
    context 'it should create the init script' do
      it do
        is_expected.to contain_file('/lib/systemd/system/jupyterhub.service').with(
          'ensure' => 'present',
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0751'
        )
      end
      it do
        is_expected.to contain_service('jupyterhub').with(
          'ensure'     => 'running',
          'enable'     => true,
          'hasrestart' => true,
        )
      end
    end
  end
  context 'it should fail on unsupported operating systems' do
    let(:facts) do
      {
        :operatingsystem => 'windows',
        :osfamily        => 'windows',
        :kernelrelease   => '6.9',
      }
    end
    it do
      is_expected.to raise_error(Puppet::Error, /Unsupported platform/)
    end
  end
end
