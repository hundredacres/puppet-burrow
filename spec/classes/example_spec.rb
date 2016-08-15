require 'spec_helper'

describe 'burrow' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "burrow class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('burrow::params') }
          it { is_expected.to contain_class('burrow::install').that_comes_before('Class[burrow::config]') }
          it { is_expected.to contain_class('burrow::config') }
          it { is_expected.to contain_class('burrow::service').that_subscribes_to('Class[burrow::config]') }

          it { is_expected.to contain_service('burrow') }
          it { is_expected.to contain_package('burrow').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'burrow class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('burrow') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
