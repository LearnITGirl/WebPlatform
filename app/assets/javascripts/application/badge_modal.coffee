window.litg ||= {}

Badge =

  showNewBadgeInfo: ->
    that = this
    description = $('.new-badge').data("description")
    src = $('.new-badge').data("src")
    title = $('.new-badge').data("name")

    if description && src && title
      @populateModal(src, title, description)
      $('#badge-info').modal('show')

    $('#badge-info').on "hidden.bs.modal", ->
      if description
        description = null
        $('.new-badge').data("description", null)
        that.updateBadgeDisplay($('.new-badge').data("id"))

  showBadgeInfo: ->
    that = this
    $('.badge-thumbnail').on "click", ->
      src = $(this).attr("data-src")
      description = $(this).attr("data-description")
      name = $(this).attr("data-name")

      $('#badge-info').on 'show.bs.modal', ->
        that.populateModal(src, name, description)

  populateModal: (src, title, description) ->
    $(".show-badge").attr("src", src)
    $(".modal-header .modal-title").text(title)
    $(".badge-description").text(description)

  updateBadgeDisplay: (id) ->
    $.ajax
      url: "/assigned_badges/#{id}"
      type: "put"
      data:
        badge_id: id

  init: ->
    @showBadgeInfo()
    @showNewBadgeInfo()

window.litg.Badge = Badge

$ ->
  if $('.badge-icon').length > 0 || $('.badge-thumbnail').length > 0 || $('.new-badge').length > 0
    Badge.init()
