module Deliver
  class Context
    attr_accessor :context
    attr_accessor :args
    
    def self.instance
      @@instance ||= Context.new
    end
  end
end
