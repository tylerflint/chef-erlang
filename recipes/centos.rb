
include_recipe 'yum'

case node['erlang']['install_type']
when 'package'
  
  cookbook_file "/etc/yum.repos.d/esl-erlang.repo"

  package "esl-erlang" do
    options "--nogpgcheck"
    action :upgrade
  end

when 'source'

  # nothing here yet

else
  Chef::Log.error("install_type must be package or source")
  exit(1)
end

