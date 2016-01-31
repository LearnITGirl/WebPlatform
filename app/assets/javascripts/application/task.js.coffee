window.litg || = {}

Task =
  updateStatus: ->
    $('input[type="checkbox"][name="task[status]"]').change ->
      $(this).closest('form').submit()

  init: ->
    @updateStatus()

window.litg.Task = Task

$ ->
  if $('.task-form').length
    Task.init()
