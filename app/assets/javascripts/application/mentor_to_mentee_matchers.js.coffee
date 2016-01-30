$ ->
  $('#match-form').on('ajax:success', (event, xhr, status, error) ->
    $(this).find('.info').append("Matched "+xhr.number+" new pairs. Please refresh the page to see results.")
  )

  $('.pair-accepted').on('ajax:success', (event, xhr, status, error) ->
    $(this).parents(".pair-actions").addClass('hidden')
    $(this).parents(".pair-actions").siblings(".pair-accepted").removeClass('hidden')
  )

  $('.mentor-rejected, .mentee-rejected').on('ajax:complete', (event, xhr, status, error) ->
    console.log($(this).parents(".pair-actions"))
    $(this).parents(".pair-actions").addClass('hidden')
    $(this).parents(".pair-actions").siblings(".pair-rejected").removeClass('hidden')
  )
