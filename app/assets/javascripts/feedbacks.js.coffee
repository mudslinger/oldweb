$(->
  if (navigator.geolocation)
    $('#search_shop').css('display','inline')
    $('#search_shop').on 'click', ->
      navigator.geolocation.getCurrentPosition (pos)=>
        $('#lat').val pos.coords.latitude
        $('#lng').val pos.coords.longitude
        p = $(@).attr('data-href') + '&' + $.param {lat: pos.coords.latitude,lng:pos.coords.longitude}
        console.log p
        ll = {lat: pos.coords.latitude,lng:pos.coords.longitude}
        $.get $(@).attr('data-href'),ll, (data)->
          console.log data
          eval(data)
      ,(err)->
        alert '申し訳ありません。現在位置の取得に失敗しました。'
      false
  else
    $('#search_shop').css('display','hidden')


)