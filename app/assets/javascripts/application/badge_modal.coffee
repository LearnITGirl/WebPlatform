window.litg || = {}

Badge =

  showBadgeInfo: ->
    $('.badge-thumbnail').on "click", ->
      src = $(this).attr("data-src")
      description = $(this).attr("data-description")
      name = $(this).attr("data-name")

      $('#badge-info').on 'show.bs.modal', ->
        $(".show-badge").attr("src", src)
        $(".modal-header .modal-title").text(name)
        $(".badge-description").text(description)

  init: ->
    @showBadgeInfo()

window.litg.Badge = Badge

$ ->
  if $('.badge-icon').length > 0 || $('.badge-thumbnail').length > 0
    Badge.init()
