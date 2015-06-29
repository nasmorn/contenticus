window.CMS ||= {}

$(document).on 'page:restore page:load ready', ->
  window.CMS.current_path = window.location.pathname
  window.CMS.init()

window.CMS.init = ->
  CMS.sortable_list()
  CMS.sortable_sections()
  CMS.wysiwyg()

window.CMS.sortable_list = ->
  $('ul.sortable').sortable
    handle: '.icon'
    axis:   'y'
    update: ->
      $.post("#{window.CMS.current_path}/reorder", "_method=put&#{$(this).sortable('serialize')}")

window.CMS.sortable_sections = ->
  $('.fields-wrapper.sortable').sortable
    handle: 'span.dragger'
    axis:   'y'
    update: (event, ui)-> 
      i = 0
      $(item).children(".position").val(i++) for item in $(this).children(".panel")

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