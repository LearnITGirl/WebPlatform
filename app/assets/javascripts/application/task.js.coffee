window.litg || = {}

Task =
  updateStatus: ->
    $('input[type="checkbox"][name="task[status]"]').change ->
      $(this).closest('form').submit()

  trash: ->
    $('.trash-task').click ->
      self = $(this)
      id = self.data('id')
      $.ajax
        url: "/tasks/#{id}"
        type: "put"
        data:
          task:
            status: "trash"
      .success ->
        window.location.reload()

  undo: ->
    $('.undo-trash-task').click ->
      self = $(this)
      id = self.data('id')
      $.ajax
        url: "/tasks/#{id}"
        type: "put"
        data:
          task:
            status: "not_done"
      .success ->
        window.location.reload()

  init: ->
    @updateStatus()
    @trash()
    @undo()

window.litg.Task = Task

$ ->
  if $('.task-form').length > 0
    Task.init()
