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
      count_total_score()
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
      count_total_score()
    )

    $('.other-score').change( ->
      option = $(this).parents('.evaluation').find('select:first option:contains("other")')
      option.val( $(this).val() )
      count_total_score()
    )

  soundnessGetChanged: ->
    $('[id^="soundness"]').change ->
      count_total_score()

  menteeTotalScore: ->
    m = c = l = e = s = sp = 0
    $('select[id^="evaluation_M"]').each ->
      m += $(this).val()*1
    $('select[id^="evaluation_C"]').each ->
      c += $(this).val()*1
    $('select[id^="evaluation_L"]').each ->
      l += $(this).val()*1
    $('select[id^="evaluation_E"]').each ->
      e += $(this).val()*1
    $('[id^="soundness_"]:checked').each ->
      s += $(this).val()*1
    if s > 0
      sp = s / ($('[name="max_soundness"]').val()*10)
    (m * 2 + c * 1 + l * 2 + e * 1) * (1 - sp)

  mentorTotalScore: ->
    m = a = k = 0
    $('select[id^="evaluation_M"]').each ->
      m += $(this).val()*1
      console.log m
    $('select[id^="evaluation_A"]').each ->
      a += $(this).val()*1
      console.log a
    $('[id^="evaluation_K"]').each ->
      k += $(this).val()*1
      console.log k
    (m * 3 + a * 2 + k * 2)

  init: ->
    @languageScoreCounter()
    @customDropdowns()
    @otherFieldScoreToggler()
    @soundnessGetChanged()

$ ->
  Evaluation.init()

count_total_score = ->
  if($('.mentee_evaluation').length > 0)
    $('#total_score').text Evaluation.menteeTotalScore()
  else if($('.mentor_evaluation').length > 0)
    $('#total_score').text Evaluation.mentorTotalScore()
