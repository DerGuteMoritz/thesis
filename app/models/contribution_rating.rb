class ContributionRating < ActiveRecord::Base  
  belongs_to :user
  belongs_to :contribution
  
  @@types = [ :style, :argumentative_weight ]
  def self.types
    @@types
  end
  
  def type
    return nil unless self[:type_id]
    @@types[self[:type_id]]
  end
  
  def type= t
    self[:type_id] = (t && @@types.index(t))
  end
  
  def weight
    # use user groups to determine this
    1
  end
end
