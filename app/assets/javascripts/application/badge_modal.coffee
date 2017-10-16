window.litg || = {}

Badge =

  showNewBadgeInfo: ->
    description = $('.new-badge').data("description")
    src = $('.new-badge').data("src")
    title = $('.new-badge').data("name")

    if description && src && title
      $(".show-badge").attr("src", src)
      $(".modal-header .modal-title").text(title)
      $(".badge-description").text(description)
      console.log("show")
      $('#badge-info').modal('show')
      description = null
      $('.new-badge').data("description", null)

    $('#badge-info').on "hidden.bs.modal", ->
      $('.new-badge').attr("data-description", null)
      $('.new-badge').attr("data-src", null)
      $('.new-badge').attr("data-name", null)
      description = null

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
    @showNewBadgeInfo()

window.litg.Badge = Badge

$ ->
  if $('.badge-icon').length > 0 || $('.badge-thumbnail').length > 0 || $('.new-badge').length > 0
    Badge.init()
