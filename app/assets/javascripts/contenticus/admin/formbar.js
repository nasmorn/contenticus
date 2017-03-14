$(document).on('turbolinks:load', function(){
  $("body").on('click', "#formbar .btn-success", function() {
    $("#formbar_close_after_save").val($(this).attr('data-close'))
    $("form").submit()
  })
})