#
# Cookbook Name:: dr_replication
# Recipe:: install_xtrabackup
#

# Required for xtrabackup
enable_package "app-arch/lz4" do
  version '1.8.3'
end

package "app-arch/lz4" do
  version '1.8.3'
  action :install
end

# Install xtrabackup
enable_package "dev-db/percona-xtrabackup" do
  version '2.4.13'
end

package "dev-db/percona-xtrabackup" do
  version '2.4.13'
  action :install
end

# Download qpress from the URL specified in attributes (used for compression)
bash "download-qpress" do
  user node['owner_name']
  cwd "/home/#{node['owner_name']}/"
  code "wget -U 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)' #{node[:dr_replication][:qpress_download_url]}"
  not_if { File.exists? "/home/#{node['owner_name']}/#{node[:dr_replication][:qpress_download_url].split("/").last}"}
end

# Untar qpress
bash "copy-qpress" do
  user node['owner_name']
  cwd "/home/#{node['owner_name']}/"
  code "tar xvf #{node[:dr_replication][:qpress_download_url].split("/").last}"
end

# Copy apress into /usr/bin so that it's in the PATH
bash "copy-qpress" do
  user "root"
  code "yes | cp -ruf /home/#{node['owner_name']}/qpress /usr/bin/"
end
