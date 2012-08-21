# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@right_container = (options) ->

  # Defaults
  open_width = "250px"
  closed_width = "2px"
  duration = 300 # ms

  # Overrides
  if options
    url ?= options.url
    open_width ?= options.open_width
    closed_width ?= options.closed_width
    duration ?= options.duration

  open: ->
    console.log(url,open_width,closed_width,duration)
    $(".right_container").animate({width: open_width}, duration)

  close: ->
    $(".right_container").animate({width: closed_width}, duration)

$ ->
  @rc = new right_container