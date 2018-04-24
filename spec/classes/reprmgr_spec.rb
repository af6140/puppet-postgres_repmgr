require 'spec_helper'
describe 'postgres_repmgr' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts[:fqdn] = 'test.dev.example.com'
        facts
      end
      let(:params) { {
        :pg_version => '9.6',
        :node_id => '1',
        :node_priority => 101,
        :primary_node => 'test.dev.example.com',
      } }

      it { should contain_class('postgres_repmgr') }

      it { should contain_package('repmgr96')}
      it { should contain_file('/etc/repmgr/9.6/repmgr.conf')
        .with_content(/node_id=1/)
        .with_content(/node_name=test.dev.example.com/)
        .with_content(/priority=101/)
        .with_content(/conninfo='host=127.0.0.1 user=repmgr dbname=repmgr/)
        .with_content(/failover=manual/)
        .with_content(/replication_user='repmgr'/)
        .with_content(/log_file='\/var\/log\/repmgr\/repmgr.log'/)
        .with_content(/pg_bindir=\/usr\/pgsql-9.6\/bin/)
        .with_content(/data_directory='\/var\/lib\/pgsql\/9.6\/data/)

      }

      it { should contain_service('repmgr96')}
    end
  end
end
