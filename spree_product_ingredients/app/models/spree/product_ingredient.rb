class Spree::ProductIngredient < ActiveRecord::Base
  attr_accessible :ingredient_id, :product_id, :amount_per_serving
  belongs_to :product
  belongs_to :ingredient
end
