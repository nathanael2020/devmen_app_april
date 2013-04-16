Deface::Override.new(:virtual_path => "spree/products/index",
                     :name => "search_result_for_ingredients",
                     :replace => "[data-hook='search_results']",
                     :partial => "spree/shared/ingredient_search_result",
                     :disabled => false)
