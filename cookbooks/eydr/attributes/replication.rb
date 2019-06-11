default[:dr_replication] = {
  :production => {
    :master => {
      :public_hostname => ""
    },
    # MySQL Only
    :initiate => {
      :public_hostname => ""
    },
    :slave => {
      :public_hostname => ""
    }
  },
  # The following URL is required for compressing/decompressing backups
  :qpress_download_url => "http://www.quicklz.com/qpress-11-linux-x64.tar"
}

# Set to true to establish replication during Chef run
default[:establish_replication] = false

# Set to true to failover to D/R environment during Chef run
default[:failover] = false
