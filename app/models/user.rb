class User < ActiveRecord::Base
  has_many :attacks, :class_name => "Battle", :foreign_key => "attacker_id"
  has_many :defenses, :class_name => "Battle", :foreign_key => "defender_id"
	has_one :user_rank

	after_create :prepare

  def battles
    attacks + defenses
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
  def prepare
  	UserRank.default(self)
  end
end
