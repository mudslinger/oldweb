#= require jquery
#= require jquery_ujs
## require jquery.ticker
#= require jquery.ui.resizable
#= require jquery.ui.selectable
#= require jquery.ui.dialog
#= require swfobject
#= require jquery.leanModal.min
#= require jquery.ui.map.full.min
#= require_tree .



$ ->
  $(".tab#recruit").find('img').attr('src',$('#stab').attr('src'))
  $(".tab#property").find('img').attr('src',$('#btab').attr('src'))

  $(".tab#recruit").hover ->
    $(@).find('img').attr('src',$('#stabp').attr('src'))
  ,->
    $(@).find('img').attr('src',$('#stab').attr('src'))
  $(".tab#property").hover ->
    $(@).find('img').attr('src',$('#btabp').attr('src'))
  ,->
    $(@).find('img').attr('src',$('#btab').attr('src'))

  $("#modal").dialog() if $("#modal")
  $("#error_explanation").dialog() if $("#error_explanation")
