class User < ApplicationRecord
  has_many :events

  def self.from_auth_hash(provider, auth_hash)
    user = new
    user.provider = provider
    user.uid = auth_hash['uid']
    user.name = auth_hash['name']
    user.email = auth_hash['email']
    return user
  end

end
