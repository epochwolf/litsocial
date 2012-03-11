// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree ./site

$(function(){
  //Activate html editor
  $( 'textarea[data-widget=ckeditor]' ).ckeditor();
  $('a[rel=popover]').popover()
})

function start_modal_spinner(){
  $('#please_wait').modal('show');
}

function stop_modal_spinner(){
  $('#please_wait').modal('hide');
}


function flatten_serialized_array(arr){
  var r = {};
  $.each(arr, function(index, value){
    r[value.name] = value.value
  })
  return r
}
