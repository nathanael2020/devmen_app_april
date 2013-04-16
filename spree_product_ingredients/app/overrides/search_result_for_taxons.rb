Deface::Override.new(:virtual_path => "spree/taxons/show",
                     :name => "search_result_ingredients_for_taxon_page",
                     :replace => "[data-hook='taxon_products']",
                     :partial => "spree/shared/ingredient_search_result",
                     :disabled => false)
