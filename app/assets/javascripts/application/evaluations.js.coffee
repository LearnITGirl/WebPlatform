#= require 'select2.min'

Evaluation =
  languageScoreCounter: ->
    $('.language > div > select').change( ->
      all_languages = $('.language > div > select')
      values = 0

      $.each(all_languages, (index, select) ->
        values += parseInt($(select).val())
      )

      average_score = values/(all_languages.length)
      $('.language-score').val(average_score) if average_score != undefined
    )

  customDropdowns: ->
    $('select').select2({
      placeholder: "Select answer that fits the most",
      minimumResultsForSearch: Infinity
    })

  otherFieldScoreToggler: ->
    $('.evaluation').find('select').change( ->
      if $(this).val() == 'other'
        $(this).parent().find('.other').show()
      else
        $(this).parent().find('.other').hide()
    )

    $('.other-score').change( ->
      option = $(this).parents('.evaluation').find('select:first option:contains("other")')
      option.val( $(this).val() )
    )


  init: ->
    @languageScoreCounter()
    @customDropdowns()
    @otherFieldScoreToggler()

$ ->
  Evaluation.init()

