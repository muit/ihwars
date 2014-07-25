
require "activerecord"

#//DATABASE////////

class DBRetriever
  def initialize (adaptor = DBAdaptor)
    @adaptor = adaptor.new
  end
  def get
    @adaptor
end



end

class DBAdaptor
  attr_accessor :state
  def initialize
    @state = true
  end
end

#Tables
class Station < Activerecord::Base
end

