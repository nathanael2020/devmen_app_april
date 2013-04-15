class ProductIngredient < ActiveRecord::Base
  attr_accessible :ingredient_id, :product_id, :quantity
end
