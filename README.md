# Rails Server Bootstrap

This repo has just enough in it to start serving a Rails app on a single,
fresh Ubuntu server, using Ruby 1.9 from standard packages, nginx, unicorn,
postgresql and `git push`-style (partial) automation of deployments.
It sets up the server using [Ansible](http://ansible.cc/docs).

## Using it

To try it in your project, do this:

* Install [Ansible](http://www.ansibleworks.com/docs/intro_installation.html) (version >= 1.4).
* Add `gem "unicorn"` to your Gemfile, run `bundle install`, commit.
* In the root of your Rails project, run this:

        curl -L https://github.com/chrisberkhout/rails_server_bootstrap/tarball/master | \
        tar xzv --strip-components=1 --exclude README.md

  and commit the new files.
* Spin up a fresh Ubuntu server somewhere and make sure you have passwordless
  authentication set up for yourself to the `ubuntu` user.
* In `deploy/hosts`, replace `example.com` with your server's hostname, commit.
* Run `rake deploy:setup` to build the server.
* Add the server as a git remote and push your code to it:

        git remote add cloud ubuntu@example.com:/var/www/railsapp
        git push cloud master

  Then follow the instructions given by the git hook.

## Really using it

This is just a starting point. Read and understand what the Ansible playbook
is doing, because you'll need to change things if you want to secure the
database, automate more parts of the deployment, deploy to multiple machines,
handle sensitive configuration data, and so on.

