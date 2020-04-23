window.litg ||= {}

ReadMore =
  initializeDotDot: ->
    $('.dot-dot-dot').dotdotdot
      wrap: "word"
      after: "a.read-more"
      height: 100

  init: ->
    @initializeDotDot()

window.litg.ReadMore = ReadMore

$ ->
  if $('a.github').length
    ReadMore.init()
