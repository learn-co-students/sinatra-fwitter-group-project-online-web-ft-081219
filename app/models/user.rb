class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets


  def slug
    #binding.pry
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-", " ").titleize
    User.all.find{|p| p.slug == slug}
      #binding.pry
  end
end
