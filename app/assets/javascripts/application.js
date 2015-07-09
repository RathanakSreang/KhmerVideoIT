// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require chosen-jquery
//= require ckeditor/init
//= require rails.validations
//= require_tree .
function add_fields(link, assoc, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + assoc, "g")
  $(link).before(content.replace(regexp, new_id));
}
function tag_choosen() {
  return $(".tags_choosen").chosen({
    allow_single_deselect: true,
    no_results_text: "No results matched",
    // width: "200px"
  });
};
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".form-group").hide();
}
$(document).ready(ready);
$(document).on("page:load", ready);
$(document).on("page:update", ready);
function ready(){   
  tag_choosen();  
}
function PreviewImage() {
  var oFReader = new FileReader();
  oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);

  oFReader.onload = function(oFREvent) {
    document.getElementById("uploadPreview").src = oFREvent.target.result;
  };
};
