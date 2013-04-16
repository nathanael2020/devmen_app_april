module Spree::Search
  class ProductIngredient < Spree::Core::Search::Base

    def retrieve_products
      @products_scope = get_base_scope
      curr_page = page || 1

      @products = @products_scope.includes([:master => :prices])
      unless Spree::Config.show_products_without_price
        @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency)
      end

      base_sql = "( spree_products.id in (#{@products.select('spree_products.id').to_sql}))"
      if (ingredient_sql = Spree::Ingredient.search_product_ids(keywords)).present?
        ingredient_sql = "( spree_products.id in (#{ingredient_sql.to_sql}))"
      else
        ingredient_sql = ''
      end
      if (review_sql = review_subquery(keywords)).present?
        review_sql = "(spree_products.id in (#{review_sql})) "
      else
        review_sql = ''
      end


      @products = Spree::Product.where([base_sql, ingredient_sql, review_sql ].select(&:present?).join(" OR "))
      @products = @products.page(curr_page).per(per_page)
    end

    def review_subquery(query)
      query = [query].compact.map(&:split).flatten.compact
      return nil if query.blank?
      first_keyword = query.shift
      like_sql = Spree::Review.arel_table[:title].matches("%#{first_keyword}%").or(Spree::Review.arel_table[:review].matches("%#{first_keyword}%"))
      query.each do |q|
        like_sql = like_sql.or(Spree::Review.arel_table[:title].matches("%#{q}%").or(Spree::Review.arel_table[:review].matches("%#{q}%")))
      end

      Spree::Review.select("spree_reviews.product_id").where(like_sql).to_sql
    end

  end
end
