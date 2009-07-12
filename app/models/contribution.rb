class Contribution < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
  belongs_to :category
  
  has_many :ratings, :class_name => 'ContributionRating'
  
  acts_as_nested_set
  
  # direct votes count only a part of the sub-arguments
  DIRECT_VOTE_SIGNIFICANCE = 0.1
  
  @@types = [ :pro, :contra, :ambivalent ]
  def self.types
    @@types
  end
  
  def to_s
    title
  end
  
  def type
    return nil unless self[:type_id]
    @@types[self[:type_id]]
  end
  
  def type= t
    self[:type_id] = (t && @@types.index(t))
  end
  
  def thesis?
    not category.nil?
  end
  
  # returns a multiplicator for the orientation realtive to the thesis
  def absolute_orientation
    current = self
    orientation = 1
    until current.thesis?
      orientation *= current.multiplicator
      current = current.parent
    end
    orientation
  end
  
  def ratings_by_type t
    ratings.to_a.find_all { |r| r.type == t }
  end
  
  def average_rating_by_type t
    r = ratings_by_type(t)
    Contribution.weighted_sum(r) do |i|
      [i.value, i.weight]
    end
  end
  
  ContributionRating.types.each do |t|
    define_method '%s_ratings' % t do
      ratings_by_type t
    end
    
    define_method '%s_ratings_weighted_count' % t do
      ratings_by_type(t).inject(0) { |x,i| x + i.weight }
    end
    
    define_method 'average_rating_%s' % t do
      average_rating_by_type t
    end
  end
  
  # rating system
  
  def reliability
    ratings_reliability
  end
  
  # the more votes there are, the more the rating is trusted
  def ratings_reliability
    x = argumentative_weight_ratings_weighted_count
    #x = Math.sqrt(Math.sqrt(x))
    #-1/(x+1)**0.7+1
    1/(1+2**(-(x.to_f/6)+5))
  end
  
  def oriented_weight
    weight * multiplicator
  end
  
#   def ratings_significance
#     ratings_reliability * argumentative_weight_ratings.inject(0) { |x,i| x + i.weight }
#   end
#   
#   def childrens_significance
#     children.inject(0) { |x,i| x+i.weight }
#   end
#   
#   def childrens_weight_sum
#     children.inject(0) do |x,i|
#       x + i.oriented_weight*i.weight  #*i.ratings_reliability
#     end
#   end
  
  def weight
    influences = (children || []).to_a + (argumentative_weight_ratings || []).to_a
    res = Contribution.weighted_sum(influences, 0) do |item|
      if item.is_a? Contribution
        val = item.oriented_weight
        weight = val.abs * item.reliability * item.argumentative_weight_ratings_weighted_count
      else  # ContributionRating
        val = item.value
        weight = val.abs * item.weight * DIRECT_VOTE_SIGNIFICANCE
      end
      [val, weight]
    end
    (res+1).to_f/2
  end
  
#   def weight
#     rw = rated_weight
#     # direct votes count a fourth only
#     rs = DIRECT_VOTE_SIGNIFICANCE * ratings_significance
#     cw = childrens_weight_sum
#     # normalize
#     cw = (cw+1)/2
#     cs = childrens_significance
#     return (rw*rs + cw*cs)/(rs+cs)
#   end
  
#   def weight
#     #cw = childrens_weight || 0
#     #((2*rated_weight - 1 + cw) / (children.size+1) + 1) / 2
#     list = argumentative_weight_ratings.to_a + children.to_a
#     
#     Contribution.weighted_sum(list) do |i|
#       if i.is_a? ContributionRating
#         [i.value, i.weight*0.5]  # direct votes count less than arguments
#       else
#         [(1+i.oriented_weight)/2, i.reliability*0.5*i.weight]
#       end
#     end
#   end
#   
  # the weight calculated by the direct votes to the contribution
  def rated_weight
    Contribution.weighted_sum(argumentative_weight_ratings) do |item|
      [item.value, item.weight]
    end
  end
  
  def multiplicator
    case type
      when :pro then 1
      when :contra then -1
      else 0
    end
  end
  
#    def childrens_weight
#      Contribution.weighted_sum(children) do |i|
#        [i.oriented_weight, i.reliability*0.5*i.weight]
#      end
#    end
  
private
  
  def self.weighted_sum(list, default = nil)    
    sum = 0
    divisor = 0
    
    list.each do |i|
      value, weight = yield(i)
      sum += value*weight
      divisor += weight
    end
    return default if divisor == 0
    sum/divisor
  end

end
