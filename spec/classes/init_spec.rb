require 'spec_helper'
describe 'jupyterhub' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "should contain install class" do
          it do
            is_expected.to contain_class('jupyterhub::install').that_comes_before('Class[jupyterhub::config]')
          end
        end

        context "should contain config class" do
          it do
            is_expected.to contain_class('jupyterhub::config')
          end
        end

        context "should contain service class" do
          it do
            is_expected.to contain_class('jupyterhub::service').that_subscribes_to('Class[jupyterhub::config]')
          end
        end

        context "it should compile with defaults" do
          it do
            is_expected.to compile.with_all_deps
          end
        end

      end
    end
  end
  at_exit { RSpec::Puppet::Coverage.report! }
end
