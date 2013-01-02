include_recipe 'apt'

case node['erlang']['install_type']
when 'package'
  
  execute "add_erlang_repo" do
    command "echo \"\ndeb http://binaries.erlang-solutions.com/debian precise contrib\n\" >> etc/apt/sources.list"
    not_if { `cat etc/apt/sources.list | grep erlang-solutions | wc -l`.to_i != 0 }
  end

  execute "add_erlang_key" do
    command "wget -O - http://binaries.erlang-solutions.com/debian/erlang_solutions.asc | sudo apt-key add -"
    notifies :run, "execute[apt-get update]", :immediately
    not_if { `apt-key list | grep "Erlang Solutions" | wc -l`.to_i != 0 }
  end

  execute "apt-get update" do
    action :nothing
  end

  package "esl-erlang" do
    action :upgrade
  end

when 'source'

  # nothing here yet

else
  Chef::Log.error("install_type must be package or source")
  exit(1)
end
