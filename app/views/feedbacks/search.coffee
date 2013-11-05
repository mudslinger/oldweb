$('#aja').html("<%=escape_javascript render 'search' %>")
$('.smart_select').on 'click', ->
  $("#feedback_shop_id").val($(@).attr('data-shop-id'))
  $('#aja').dialog('close')
$('#aja').dialog()