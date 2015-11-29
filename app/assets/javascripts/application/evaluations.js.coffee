#= require 'select2.min'
$ ->
  $('select').select2({
    placeholder: "Select answer that fits the most",
    minimumResultsForSearch: Infinity
  })
