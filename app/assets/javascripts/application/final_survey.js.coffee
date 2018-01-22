UpdateFileName = () ->
  $("#mentee_final_survey_form_mentee_demo_file").on('change', (e) ->
    if this.files && filename = e.target.value.split('\\').pop()
      file_size = RoundToMb(this.files[0].size)
      filename = filename + " (" + file_size + ")"
      $(".demo-file-name").val(filename)
  )

RoundToMb = (value) ->
  val = Math.round((value/(1024*1024)) * 100) / 100
  val + "mb"

$ ->
  if $("#mentee_final_survey_form_mentee_demo_file").length
    UpdateFileName()
