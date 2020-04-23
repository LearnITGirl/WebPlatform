window.litg ||= {}

Poll =
  customAnswer: ->
    self = @
    $("input[name='poll[answer]']:radio").change ->
      if $(this).val() == "Other"
        $(this).val($("#other_language").val())
        $("#other_language").show()
      else
        $("#other_language").hide()
        self.clearOther()

    $("#other_language").keyup ->
      $("#poll_answer_other").val($(this).val())

  respond: ->
    self = @
    $("#poll-form").on "ajax:success", (e, data) ->
      self.toggleAlert(true, $(this), data["msg"])
      self.clearOther()
      $("#poll_answer_c").prop("checked", true)
      $("#other_language").hide()

    $("#poll-form").on "ajax:error", (e, data) ->
      response = JSON.parse(data.responseText)
      self.toggleAlert(false, $(this), response["msg"])

  clearOther: ->
    $("#other_language").val("")
    $("#poll_answer_other").val("Other")

  toggleAlert: (success, element, text) ->
    removeClass = if success then "alert-danger" else "alert-success"
    addClass = if success then "alert-success" else "alert-danger"

    alert = element.siblings(".alert")
    alert.text(text)
    alert.removeClass("hidden #{removeClass}")
    alert.addClass("#{addClass}")

  init: ->
    @respond()
    @customAnswer()

window.litg.Poll = Poll

$ ->
  if $('#poll-form').length
    Poll.init()
