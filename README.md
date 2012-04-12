[deliver tool]
===

Run commands or upload a file for each server in a list.

Usage
--------

    deliver ./script.dsl
    
Script: script.dsl
--------
    
    default_user "root"
    default_password "password"
    
    # username and password use default
    server "yourhost.com"
    # set username and password for a server
    server "yoursecondhost.com", "username", "password"
    
    script "Script Name" do |args|
      # run command at remote server
      puts ssh("ls -lh")
      # upload a file to remote server
      upload "/filesourcepath/filename", "/destpath"
      # run command at local
      puts sh("ls -lh")
    end

Split script and server define
--------
servers.dsl

    default_user "root"
    default_password "password"
    
    server "yourhost.com"
    server "yoursecondhost.com"
    
script.dsl

    include "servers.dsl"
    script "Script Name" do |args|
      puts ssh("ls -lh")
    end

Arguments
--------
When you command looks like:
`deliver script.dsl arg1 arg2`

the args params for script block is:
`args #=> [arg1, arg2]`

For example:
`deliver script.dsl "/root"`

script.dsl

    include "servers.dsl"
    script "Script Name" do |args|
      puts ssh("ls -lh #{args[0]}")
    end

it will run "ls -lh /root" at each server.

Require:
--------
  - net-ssh
  - net-scp