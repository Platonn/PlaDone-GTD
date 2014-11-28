# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Reference jQuery

#$.fn.child = (x) -> @children(x)[0]

ready = ->

  #alert "spike"
  # task done toggle
  $('.done-check > a').click ->
    dataAttr = $(this).data()
    # View:
    taskRow = $(this).closest(".task-row")
    spanImage = $(this).children("span")

    toggleView = ->
      taskRow.toggleClass('success')
      taskRow.toggleClass('done')
      spanImage.toggleClass('glyphicon-ok')
      spanImage.toggleClass('glyphicon-screenshot')

    #toggleView()

    # AJAX:
    $.ajax
      type: "GET"
      url:  "/tasks/#{dataAttr.taskId}/toggle_done"
      success:(data) ->
        if data.success
          console.log "Toggle done success!"
          toggleView()
          return false
      error:(data) ->
        alert "Could not toggle done! Try again later."
        console.log "Could not toggle done! Try again later."
        return false

    #console.log("task clicked!")

$(document).ready(ready)
$(document).on('page:load', ready)

### spike:
# Widget definition:
$.widget "tasks.toggleDoneWidget",
  _create: ->
    console.log("created")
    @element.on "click", =>
      console.log("clicked")
###



###
# Plugins definitions:
$.fn.extend
  toggleDone: (options) ->
    # Default settings
    settings =
      debug: true

    # Merge defalut settings with options
    settings = $.extend settings, options

    # Simple logger
    log = (msg) ->
      console?.log msg if settings.debug

    log "toogleDone plugin set up."


    @each ->
      $(this).click ->
        log "task-row clicked"
        dataAttr = taskId: 29 # spike! this.data()
        $.ajax
          type: "GET"
          url:  "/tasks/#{dataAttr.taskId}/toggle_done"
          data: { id: dataAttr.taskId }
          success:(data) ->
            alert data.id + "toggled"
            return false
          error:(data) ->
            alert "error!"
            return false


    # Set up events


$(".task-row").toggleDone
  debug: true
###