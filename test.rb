require './deliver_dsl'

def load_code(script_name)
  current_path = File.dirname(__FILE__)
  test_path = current_path + "/test/"
  code = ""
  File.open(test_path + script_name, "r") do |fp|
    code = fp.read
  end
  code
end

DeliverDSL::Executor.execute_code(load_code("test.dsl"), [1])