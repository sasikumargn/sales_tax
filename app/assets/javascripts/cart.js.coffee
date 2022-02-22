# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $('#currency_type').on 'change', ->
    valuesToSubmit = $('form#cart_select').serialize();
    $.ajax
      url: $('form#cart_select').attr('action'),
      type: "PUT",
      dataType: "script",
      data: valuesToSubmit
    return

$(document).ready(ready)