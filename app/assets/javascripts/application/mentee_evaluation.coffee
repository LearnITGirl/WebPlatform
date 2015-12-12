# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('select[id^="evaluation"]').change ->
  if $(this).find('option:selected').text() == 'Other'
    $(this).parent().find('.other').show()
  else
    $(this).parent().find('.other').hide()
  $('#total_score').text total_score()
  return
$('')
$('.other-score').change ->
  $(this).parentsUntil('.evaluations').find('.evaluation select option:selected').val $(this).val()
  $('#total_score').text total_score()
  return
$('[id^="soundness"]').change ->
  $('#total_score').text total_score()
  return
total_score = ->
  m = 0
  c = 0
  l = 0
  e = 0
  s = 0
  sp = 0
  $('select[id^="evaluation_M"]').each ->
    m += $(this).val()*1
    return
  $('select[id^="evaluation_C"]').each ->
    c += $(this).val()*1
    return
  $('select[id^="evaluation_L"]').each ->
    l += $(this).val()*1
    return
  $('select[id^="evaluation_E"]').each ->
    e += $(this).val()*1
    return
  $('[id^="soundness_"]:checked').each ->
    s += $(this).val()*1
    return
  if s > 0
    sp = s / ($('[name="max_soundness"]').val()*10)
  return (m * 2 + c * 1 + l * 2 + e * 1) * (1 - sp)
  return