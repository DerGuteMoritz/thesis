class User < ActiveRecord::Base
  has_many :contributions
  has_many :theses
  
  def to_s
    name
  end
end
