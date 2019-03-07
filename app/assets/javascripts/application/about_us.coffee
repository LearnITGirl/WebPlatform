window.litg ||= {}

AboutUs =
  showCollapsible: ->
    that = this
    $('.collapsible').on "click", ->
      if $(this).is('.collapse:not(.show)')
        $(this).slideUp(100);
        $(this).next().slideToggle();
      else
        $(this).slideDown(100);
        $(this).next().slideToggle();

  init: ->
    @showCollapsible()

window.litg.AboutUs = AboutUs

$ ->
  AboutUs.init()