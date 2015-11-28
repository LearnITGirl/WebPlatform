window.litg || = {}

Newsletter =
  respond: ->
    self = @
    $("#subscribe").on "ajax:success", (e, data) ->
      self.toggleAlert(true, data["msg"])
      $('#email').val('')

    $("#subscribe").on "ajax:error", (e, data) ->
      response = JSON.parse(data.responseText)
      console.log response
      self.toggleAlert(false, response["msg"])

  toggleAlert: (success, text) ->
    removeClass = if success then "alert-danger" else "alert-success"
    addClass = if success then "alert-success" else "alert-danger"

    alert = $('#status-message')
    alert.text(text)
    alert.removeClass("hidden #{removeClass}")
    alert.addClass("#{addClass}")

  init: ->
    @respond()

window.litg.Newsletter = Newsletter

$ ->
  if $('#subscribe').length
    Newsletter.init()
