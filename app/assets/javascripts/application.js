// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.8.23.custom.min
//= require twitter/bootstrap
//= require redactor-rails
//= require redactor-rails/fix_config_not_working
//= require_tree ./site

function update_modal_message(title, message){
  if(title != null){
    $('#modal_message div.modal-header h3').html(title);
  }
  if(message != null){
    $('#modal_message div.modal-body').html(message);
  }
}

function dismiss_modal_message(){
  $('#modal_message').modal('hide').remove();
}