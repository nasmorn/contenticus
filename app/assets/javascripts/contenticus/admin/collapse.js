// The codemirror editor needs to be reinitialized after the collapsed element
// is fully shown. It needs access to the current size of the element
// Otherwise it has some display errors
$(document).on('turbolinks:load', function(){
  $('.block').on('shown.bs.collapse', function() {
    $(this).find('.CodeMirror').each(function(i, el){
        el.CodeMirror.refresh();
    });
  })
})
