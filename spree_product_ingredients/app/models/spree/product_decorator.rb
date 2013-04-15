Spree::Product.class_eval do
  has_many :product_ingredients
  attr_accessible :is_a_supplement

  def amount_ingredient(ingredient)
    product_ingredients.select{|j| j.ingredient == ingredient }.map{|v| v.amount_per_serving.to_f }.sum
  end
end
