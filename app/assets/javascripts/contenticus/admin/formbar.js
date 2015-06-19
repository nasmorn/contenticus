$(document).on('ready page:load', function(){
  $("body").on('click', "#formbar .btn-success", function() {
    $("form").submit()
  })
})