#= require 'jquery.autocomplete.min'

$('#participants-autocomplete').autocomplete(
  serviceUrl: '/search/participants',
  onSelect:  (suggestion) ->
    window.location.href = suggestion.data
)
