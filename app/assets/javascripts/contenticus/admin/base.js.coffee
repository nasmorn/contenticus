window.CMS ||= {}
window.Jcrop ||= {}
window.CMS.code_mirror_instances = [ ]

$(document).on 'turbolinks:load', ->
  window.CMS.current_path = window.location.pathname
  window.CMS.init()
  $('[data-toggle="tooltip"]').tooltip()

window.CMS.init = ->
  CMS.codemirror()
  CMS.sortable_list()
  CMS.sortable_sections()
  CMS.wysiwyg()
  $('.jcrop').each ->
    CMS.initJcrop($(this))
  $(document).on 'click', '.remove-collectible', ->
    $(this).parents('.collectible').remove()

window.CMS.sortable_list = ->
  $('.sortable').sortable
    handle: '.icon'
    axis:   'y'
    update: ->
      $.post("#{window.CMS.current_path}/reorder", "_method=put&#{$(this).sortable('serialize')}")

window.CMS.sortable_sections = ->
  $('.fields-wrapper.sortable').sortable
    handle: 'span.dragger'
    axis:   'y'

window.CMS.wysiwyg = ->
  csrf_token = $('meta[name=csrf-token]').attr('content')
  csrf_param = $('meta[name=csrf-param]').attr('content')

  if (csrf_param != undefined && csrf_token != undefined)
    params = csrf_param + "=" + encodeURIComponent(csrf_token)

  $('textarea.rich-text-editor:visible, textarea[data-cms-rich-text]:visible').redactor
    minHeight:        160
    autoresize:       true
    imageUpload:      "#{CMS.file_upload_path}?source=redactor&type=image&#{params}"
    imageManagerJson: "#{CMS.file_upload_path}?source=redactor&type=image"
    fileUpload:       "#{CMS.file_upload_path}?source=redactor&type=file&#{params}"
    fileManagerJson:  "#{CMS.file_upload_path}?source=redactor&type=file"
    definedLinks:     "#{CMS.pages_path}?source=redactor"
    buttonSource:     true
    formatting:       ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']
    # plugins:          ['imagemanager', 'filemanager', 'table', 'video', 'definedlinks']
    lang:             "en"
    convertDivs:      false

window.CMS.initJcrop = (original_image) ->
  x = parseFloat(original_image.parent().find(".crop_x").val())
  y = parseFloat(original_image.parent().find(".crop_y").val())
  h = parseFloat(original_image.parent().find(".crop_h").val())
  w = parseFloat(original_image.parent().find(".crop_w").val())

  selection = [x,y,w+x,h+y]
  aspect = parseFloat(original_image.parent().find(".aspect").val())
  minSize = [parseInt(original_image.parent().find(".min_size_w").val()),
             parseInt(original_image.parent().find(".min_size_h").val())]

  original_image.Jcrop({
    aspectRatio: aspect,
    onSelect: (c) ->
      window.updateJcrop(original_image, c)
    boxWidth: 520,
    boxHeight: 400,
    setSelect: selection,
    minSize: minSize,
    })


window.updateJcrop = (target, c) =>
  image_form = target.parent()
  image_form.children(".crop_x").val(c.x)
  image_form.children(".crop_y").val(c.y)
  image_form.children(".crop_h").val(c.h)
  image_form.children(".crop_w").val(c.w)

window.CMS.codemirror = ->
  $('textarea[data-cms-cm-mode]').each (i, element) ->
    cm = CodeMirror.fromTextArea element,
      mode:           $(element).data('cms-cm-mode')
      lineWrapping:   true
      autoCloseTags:  true
      lineNumbers:    true
    CMS.code_mirror_instances.push(cm)
    $(cm.display.wrapper).resizable resize: ->
      cm.setSize($(@).width(), $(@).height())
      cm.refresh()

  $('a[data-toggle="tab"]').on 'shown.bs.tab', ->
    for cm in CMS.code_mirror_instances
      cm.refresh()