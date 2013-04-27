require 'deliver'

def load_code(script_name)
  current_path = File.dirname(__FILE__)
  test_path = current_path + '/'
  code = ""
  File.open(test_path + script_name, "r") do |fp|
    code = fp.read
  end
  code
end

Deliver::Executor.execute_code(load_code("test.dsl"), [1])
