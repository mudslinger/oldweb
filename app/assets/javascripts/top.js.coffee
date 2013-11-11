$(
  if $('body.top')
    ticker = ->
      $('#news li:first').fadeOut ->
        $(@).appendTo($('#news')).fadeIn()

    setInterval(
      ticker,
      5000
    )
)