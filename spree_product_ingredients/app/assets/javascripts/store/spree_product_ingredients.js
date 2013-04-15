//= require store/spree_core

$(function(){

  $('#cart-toggle-ingredients-table').click(function(){
    $('#cart-ingredients').toggle();
    return false;
  })

  $("#update-ingredients-table").click(function(){
    $('#ingredients-table-container').load(window.location.href+'.js')
    return false;
  })
})
