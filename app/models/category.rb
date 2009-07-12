class Category < ActiveRecord::Base
  belongs_to :user
  has_many :contributions
  
  acts_as_nested_set
  
  def to_s
    name
  end
end
