# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

mediaDropzone = new Dropzone('#media-dropzone')
mediaDropzone.on 'success', (file, responseText) ->
	imageUrl = responseText.file_name.url
	return
