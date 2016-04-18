window.litg ||= {}

EditTask =

  showModal: ->
    $('a.edit-task').on 'ajax:success', (e, data) =>
      $('#edit-task-modal').html(data)

    $('#edit-task-modal').on 'ajax:success', 'form', (e, data) ->
      window.location.reload()

  showError: ->
    $('#edit-task-modal').on 'ajax:error', 'form', (e, data) ->
      $('#edit-task-modal .alert').removeClass('hidden')
      $('#edit-task-modal .form-group:first').addClass('field_with_errors')

  init: ->
    @showModal()
    @showError()


window.litg.EditTask = EditTask

$ ->
  if $('#edit-task-modal').length > 0
    EditTask.init()

