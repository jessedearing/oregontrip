class Driver < ActiveRecord::Base
  attr_accessible :name

  def self.current
    if Driver.order('updated_at DESC').exists?
      Driver.order('updated_at DESC').first
    else
      Driver.new
    end
  end
end
