class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  after_create :create_score

  def possible_opponents
    User.where('id <> ?', id)
  end

  def create_score
    Score.create_entry_for_user(self)
  end
end
