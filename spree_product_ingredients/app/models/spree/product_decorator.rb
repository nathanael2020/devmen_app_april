Spree::Product.class_eval do
  has_many :product_ingredients
  attr_accessible :is_a_supplement
end
