Spree::Product.class_eval do
  has_many :product_ingredients
  attr_accessible :is_a_supplement, :servings
  scope :supplement, where(:is_a_supplement =>true)

  def amount_ingredient(ingredient)
    product_ingredients.select{|j| j.ingredient == ingredient }.map{|v| v.amount_per_serving.to_f }.sum
  end
  class << self
    def ingredients_table(products)
      cell = Struct.new(:product, :ingredient, :product_id, :taxon_ids, :product_ingredients )
      products.map{|j|
        j.product_ingredients.map{|v| cell.new(j, v.ingredient, j.id, j.taxon_ids, j.product_ingredients ) }
      }.flatten.compact.group_by(&:ingredient)
    end
  end
  def as_json(*args)
    obj = super(*args)
    obj['product'].merge({:taxon_ids => self.taxon_ids})
  end
end
