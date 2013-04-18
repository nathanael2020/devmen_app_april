//= require store/spree_core

$(function(){

  var amount_ingredient = function(list_ingredients, calculate_ingredient ){
    var sum = 0;
    $.each(list_ingredients, function(i, item){
      var v = item.product_ingredient
      if (v.ingredient_id == calculate_ingredient.id){
        sum = sum + v.amount_per_serving;
      }
    })
    return sum;
  }
  $('#cart-toggle-ingredients-table').click(function(){
    $('#cart-ingredients').toggle();
    return false;
  })

  $("#update-ingredients-table").click(function(){
    $('#ingredients-table-container').load(window.location.href+'.js')
    return false;
  })

  $("#ingredient_taxon").on("change", function(){
    var current_taxon_id = $(this).val();
    var table = ("table.table-search-result-ingredients:first")
    var tr = ["<tr>"];
    tr.push('<th>Ingredient</th>');
    var product_ids = []
    var products = $.map(supplment_products, function(i){
      var taxon_ids = i.taxon_ids
      if ($.inArray(parseInt(current_taxon_id), taxon_ids) != -1){
        product_ids.push(i.id)
        return i
      }
    })

    $.each(products, function(i, item){
      tr.push('<th>'+item.name+'</th>');
    })
    tr.push('</tr>');

    var ingredients = $.map(ingredients_table, function(item){
      var show_item = false
      $.each(item[1], function(i, _item){
        if ($.inArray(_item.product_id, product_ids ) != -1){
          show_item = true;
        }
      });
      if (show_item){
        return [item]
      }
    });

    $.each(ingredients, function(i, item){
      tr.push('<tr>')

      tr.push('<td>')
      tr.push(item[0].ingredient.name)
      tr.push('</td>')

      $.each(products, function(i, _item){
        var item_products = item[1]
        var current_item_product =  null;
        $.each(item_products,function(v, v_item){
          if (v_item.product_id == _item.id){
            current_item_product = v_item;
          }
        })
        tr.push('<td>')
        if (current_item_product){
          tr.push(amount_ingredient(current_item_product.product_ingredients, item[0].ingredient))
          tr.push(" "+item[0].ingredient.unit)
        }
        tr.push('</td>')
      })

      tr.push('</tr>')
    });
    $("tr, thead, tbody", table).remove();
    $(table).append(tr.join(''))
  });


})
