#= require 'select2.min'

count_language_score = ->
  all_languages = $('.language > div > select')
  values = 0

  $.each(all_languages, (index, select) ->
    values += parseInt($(select).val())
  )

  average_score = values/(all_languages.length)
  $('.language-score').val(average_score) if average_score != undefined

$ ->
  $('select').select2({
    placeholder: "Select answer that fits the most",
    minimumResultsForSearch: Infinity
  })

  $('.language > div > select').change( ->
    count_language_score()
  )
