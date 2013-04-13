# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  $("select").chosen()

  $.datepicker.setDefaults( $.datepicker.regional[ "es" ] )
  $( ".date_input").datepicker(dateFormat: 'dd/mm/yy', minDate: 0, numberOfMonths: 2)
