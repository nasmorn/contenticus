$("html").on 'click', ".add-block-to-section", ->
  section = $(this).parents("section").first()
  $.get $(this).attr('data_url'), "", (data) ->     
    html = $(data).find(".fields")
    count = section.find(".fields").length
    html.children(".position").val(count)
    new_prefix = sectionDataFieldPrefix(section).replace("COUNT", count) 
    old_prefix = new RegExp("contenticus_page\\[blocks\\]", "g")
    section.children(".fields-wrapper").append(html.prop('outerHTML').replace(old_prefix, new_prefix))        
    CMS.wysiwyg()
  return false

sectionDataFieldPrefix = (section) ->
  if section.parent().hasClass("panel-body")
    section.parent().children("input").first().attr("name").replace("[layout]","[blocks_attributes][COUNT]")
  else
    "contenticus_page[master_block_attributes][blocks_attributes][COUNT]"