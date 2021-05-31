window.litg ||= {}

FilePreview =
  showAvatar: ->
    $('#user_avatar').on 'change', (e, data) ->
      files = if !!@files then @files else []
      return unless files.length > 0 and window.FileReader
      element = $(this).siblings(".display-avatar")

      if /^image/.test(files[0].type)
        reader = new FileReader()
        reader.readAsDataURL(files[0])
        reader.onloadend = ->
          element.css('background-image', "url(#{@result})")

  chooseFile: ->
    $('.display-avatar').click ->
      $('#user_avatar').trigger "click"

  init: ->
    @showAvatar()
    @chooseFile()

window.litg.FilePreview = FilePreview

$ ->
  if $('.display-avatar').length
    FilePreview.init()
