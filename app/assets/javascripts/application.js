//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require underscore
//= require gmaps/google
//= require turbolinks
//= require sync
//= require moment
//= require bootstrap-datetimepicker


$('#signUpModal').on('shown.bs.modal', function () {
  $('#user_first_name').focus();
});

$('#loginModal').on('shown.bs.modal', function () {
  $('#user_email').focus();
});
