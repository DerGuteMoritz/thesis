module ContributionsHelper
  def contrib_color(c)
    if c.absolute_orientation > 0
      color = [0,0,1]
    else
      color = [1,0,0]
    end
    w = c.weight
    color.collect! { |v| 
      v = 1-(1-v)*w
      (v*255).round
    }
    '#%02x%02x%02x' % color
  end
  
  ContributionRating.types.each do |t|
    define_method 'vote_%s_path' % t do |c, x|
      { 
        :controller => 'contributions', 
        :action => 'vote_%s' % t, 
        :params => { 
          :id => c.id, 
          :value => x,
        }
      }
    end
    define_method 'vote_%s_link' % t do |text, css_class, c, x|
      link_to text, self.send('vote_%s_path' % t, c, x), :class => css_class
    end
  end
end
