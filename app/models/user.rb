class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :feeds

  def feeds_on_page page
    feeds.paginate(page: page, per_page: 5).order("updated_at DESC")
  end
end
