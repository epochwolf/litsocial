// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

$(document).ready(function(){
  //Activate html editor
  $( 'textarea[data-widget=ckeditor]' ).ckeditor();
  
  // Bootstrap stuff
  $(".alert-message").alert();
  $('.modal').modal({show: false, keyboard: true, backdrop: true});
  
})

function start_modal_spinner(){
  $('#please_wait').modal('show');
}

function stop_modal_spinner(){
  $('#please_wait').modal('hide');
}


function copy_text_from_iframe(target, text_to_copy){
  console.log("copy_text_from_iframe('"+target+"', '"+text_to_copy+"')");
  stop_modal_spinner();
  $(target).val(text_to_copy);
}