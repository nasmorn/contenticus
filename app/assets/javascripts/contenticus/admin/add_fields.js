function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("contenticus-additional", "g");
  $(link).closest(".section").children('.fields-wrapper').append(content.replace(regexp, new_id));
  return false;
}
