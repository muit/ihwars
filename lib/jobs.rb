class Jobs 
  def initialize
    @scheduler = Rufus::Scheduler.new
    load
  end
  def load
    @scheduler.every "1d", :at => '8:00 am' do
      UserRank.update_user_ranks
    end

    @scheduler.every "1m" do
      Resources.new
    end
  end
end