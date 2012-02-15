require 'net/ssh'
require 'net/scp'

module DeliverDSL
  module Base
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    # class methods
    module ClassMethods
      def server(host, user=nil, password=nil)
        puts "Define Server #{host}"
        password = register[:default_password] if password.nil?
        user = register[:default_user] if user.nil?
        register[:servers] << {:host => host, :user => user, :password => password}
      end
      
      def default_password(password)
        puts "Define Default Password"
        register[:default_password] = password
      end
      
      def default_user(user)
        puts "Define Default User"
        register[:default_user] = user
      end
      
      def script(name="")
        register[:servers].each do |server|
          puts "Run script #{name} at server #{server[:host]}"
          begin
            create_context(server)
            begin
              yield Context.instance.args
            rescue
              puts "There has some problem in your DSL script"
            end
          rescue
            puts "Cannot connect to server #{server[:host]}"
          end
          close_context
        end
      end
      
      def sh(command)
        fp = IO.popen(command)
        fp.read
      end
      
      def ssh(command)
        current = Context.instance.context
        current[:ssh].exec!(command)
      end
      
      def upload(local, remote)
        current = Context.instance.context
        last = -1
        current[:scp].upload!(local, remote) do |ch, name, sent, total|
          last = report_progress("Upload #{name}", sent, total, last)
        end
        puts
      end
      
      def download(remote, local)
        current = Context.instance.context
        last = -1
        current[:scp].download!(remote, local) do |ch, name, sent, total|
          last = report_progress("Download #{name}", sent, total, last)
        end
        puts
      end
      
      def report_progress(title, sent, total, last)
        percent = ((sent * 1.0 / total * 1000)).to_i
        if percent > last
          print "\r#{title}: #{percent/10}%"
        end
        percent
      end
      
      # register to save some global data
      def register
        @@register ||= {:servers => [], :default_password => "", :default_user => "root"}
      end
      
      def create_ssh_connection(server)
        Net::SSH.start(server[:host], server[:user], :password => server[:password])
      end
      
      def create_scp_connection(ssh)
        Net::SCP.new(ssh)
      end
      
      def create_context(server)
        ssh = create_ssh_connection(server)
        context = {
          :ssh => ssh,
          :scp => create_scp_connection(ssh)
        }
        Context.instance.context = context
      end
      
      def close_context
        current = Context.instance.context
        current[:ssh].close() unless current.nil?
        Context.instance.context = nil
      end
      
      def set_args(args)
        Context.instance.args = args
      end
    end
  end
end