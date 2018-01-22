UpdateFileName = () ->
  $("#demo-file").on('change', (e) ->
    if this.files && filename = e.target.value.split('\\').pop()
      $("#mentee_final_survey_form_mentee_demo_url").val("file: " + filename)
  )

$ ->
  if $("#demo-file").length
    UpdateFileName()
