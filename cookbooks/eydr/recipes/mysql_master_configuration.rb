#
# Cookbook Name:: dr_replication
# Recipe:: mysql_master_configuration
#

if ['solo'].include?(node['dna']['instance_role'])
  remote_file "/etc/mysql.d/logbin.cnf" do
    source "logbin.cnf"
    owner "root"
    group "root"
    mode 0600
    backup 0
  end

  bash "restart-mysql" do
    code "/etc/init.d/mysql restart"
  end
end

if ['db_master', 'solo', 'db_slave'].include?(node['dna']['instance_role'])
  include_recipe "eydr::install_xtrabackup"
end
