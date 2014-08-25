class User < ActiveRecord::Base
	has_one :user_rank

	after_create :prepare

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
  def prepare
  	UserRank.default(self)
  end
end
