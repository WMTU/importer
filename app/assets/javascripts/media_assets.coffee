# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

load = ->
  if $('#media-dropzone').length
    mediaDropzone = new Dropzone '#media-dropzone',
      paramName: 'media_asset[audio_file]'

  $('.best_in_place').best_in_place()

$(document).ready ->
  load
  $(document).on 'turbolinks:load', load
