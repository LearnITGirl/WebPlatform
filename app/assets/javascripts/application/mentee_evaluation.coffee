# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('select').change ->
  if $(this).val() == 'Other'
    $(this).parent().find('.other').show()
  else
    $(this).parent().find('.other').hide()
  return