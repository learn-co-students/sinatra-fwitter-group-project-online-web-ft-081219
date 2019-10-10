class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :tweets
  
  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-"," ")
    self.find_by(username:name)
  end

end
