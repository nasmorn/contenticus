window.CMS ||= {}

$(document).on 'page:restore page:load ready', ->
  window.CMS.current_path = window.location.pathname
  window.CMS.init()

window.CMS.init = ->
  CMS.sortable_list()

window.CMS.sortable_list = ->
  $('.sortable').sortable
    handle: '.icon'
    axis:   'y'
    update: ->
      $.post("#{window.CMS.current_path}/reorder", "_method=put&#{$(this).sortable('serialize')}")