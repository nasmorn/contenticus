$(document).on('turbolinks:load', function(){
  $("body").on('change', "#contenticus_image_file", function(e) {
  var button  = $(this).parent()

  var fileName = '';
  fileName = e.target.value.split( '\\' ).pop();

  if( fileName )
    button.addClass('btn-success')
    button.children('.filename').text(fileName);
  })
})
