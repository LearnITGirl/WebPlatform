$ ->
  $('#match-form').on('ajax:success', (event, xhr, status, error) ->
    $(this).find('.info').html("Matched "+xhr.number+" new pairs. Please refresh the page to see results.")
  ).on('ajax:error', (event, shr, status, error) ->
    $(this).find('.info').html("Something goes wrong.")
  )
