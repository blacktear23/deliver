module DeliverDSL
  class Executor
    include DeliverDSL::Base
    
    # class methods
    class << self
      def execute_script(script_name, args=[])
        File.open(script_name, "r") do |fp|
          code = fp.read()
          execute_code(code, args)
        end
      end
      
      def execute_code(code, args=[])
        Executor.set_args(args)
        Executor.class_eval(code)
      end
      
      def include(script_name)
        File.open(script_name, "r") do |fp|
          code = fp.read()
          execute_code(code)
        end
      end
    end
  end
end