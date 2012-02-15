default_user "root"
default_password ""

server "127.0.0.1"

script "Default" do |args|
    puts args
    puts sh("ls /")
    puts ssh("ls -lh")
end