$('#subscribe').submit ->
  input = $(this).serialize()
  $.ajax(
    url: $(this).attr('action')
    type: 'POST'
    data: input).success (response) ->
    $('#status_message').removeClass 'alert-danger alert-success'
    $('#status_message').addClass 'alert-' + response.class
    $('#status_message').html response.msg
    return
  return