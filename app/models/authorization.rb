class Authorization < ActiveRecord::Base
  attr_accessible :renew_token, :token
end
