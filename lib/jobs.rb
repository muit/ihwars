class Jobs 
  def initialize
    @scheduler = Rufus::Scheduler.new
    load
  end
  def load
    @scheduler.every "1h" do
      UserRank.reload
    end

    @scheduler.every "10s" do
      Resources.new 6
    end
  end
end