window.litg ||= {}

EditTask =

  showModal: ->
    $('a.edit-task').on "ajax:success", (e, data) ->
      $('#edit-window').html(data)

  init: ->
    @showModal()


window.litg.EditTask = EditTask

$ ->
  if $('#edit-window').length > 0
    EditTask.init()

