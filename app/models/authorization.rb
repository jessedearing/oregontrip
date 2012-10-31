class Authorization < ActiveRecord::Base
  attr_accessible :renew_token, :token

  def self.current
    Authorization.order('created_at DESC').first
  end
end
