namespace :deploy do

  username = 'ubuntu'
  hostname = `ansible -i deploy/hosts all --list-hosts`.first.strip

  desc "Run Ansible playbook to set up box"
  task :setup do
    command = "time ansible-playbook deploy/setup.yml -i deploy/hosts -vv"
    puts command
    system command
  end

  desc "Connect to box via ssh"
  task :ssh do
    command = "ssh #{username}@#{hostname}"
    puts command
    exec command
  end

  desc "Trigger a unicorn restart on the server"
  task :restart do
    [
      "ssh #{username}@#{hostname} 'kill -USR2 `cat /var/www/railsapp/tmp/pids/unicorn.pid`' && sleep 25",
      "ssh #{username}@#{hostname} 'kill -WINCH `cat /var/www/railsapp/tmp/pids/unicorn.pid.oldbin`' && sleep 10",
      "ssh #{username}@#{hostname} 'kill -QUIT `cat /var/www/railsapp/tmp/pids/unicorn.pid.oldbin`'"
    ].each do |command|
      puts command
      system command
    end
  end

end

