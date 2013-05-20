Spree::ProductsController.class_eval do
  after_filter :search_ingredients, only: [:index]
  private
  def search_ingredients
    @ingredients = []
  end
end
