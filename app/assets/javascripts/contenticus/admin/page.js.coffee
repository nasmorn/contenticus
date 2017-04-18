window.CMS ||= {}

$(document).on 'turbolinks:load', ->
  $(".select2").select2({
      theme: "bootstrap"
  });

window.CMS.toggle_published = (link) ->
  checkbox = $(link).parents(".panel").find(':checkbox').first()
  original_state = checkbox.prop('checked')
  # Set to opposite
  checkbox.prop('checked', !original_state)
  # Change button color
  remove_class = if original_state then 'btn-success' else 'btn-default'
  add_class    = if original_state then 'btn-default' else 'btn-success'
  $(link).removeClass(remove_class)
  $(link).addClass(add_class)
