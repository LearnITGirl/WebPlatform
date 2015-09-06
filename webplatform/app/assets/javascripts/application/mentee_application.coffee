window.learnItGirl ||= {}

MenteeApplication =
  showExtraQuestions: ->
    if $('#mentee_application_programming_level_medium').is(":checked") || $('#mentee_application_programming_level_advanced').is(":checked")
      $('.extra-question').show()
    else
      $('.extra-question').hide()

  programmingLevel: ->
    $("input[type='radio'][name='mentee_application[programming_level]']").change =>
      @showExtraQuestions()

  init: ->
    @showExtraQuestions()
    @programmingLevel()

$ ->
  if $('#mentee_application_background').length
    MenteeApplication.init()
