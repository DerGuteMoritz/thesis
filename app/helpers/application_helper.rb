# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def f(x, digits = 2)
    return 'nil' unless x
    h format("%.#{digits.to_i}f",x)
  end
end
