class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  def possible_opponents
    User.where('id <> ?', id)
  end
end
