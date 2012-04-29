// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree ./site

$(function(){
  //Activate html editor
  $( 'textarea[data-widget=ckeditor]' ).ckeditor();
  $('a[rel=popover]').popover();
})



function replace_callback(selector){
  return function(data, status, xhr){ 
    $(selector).replaceWith(data["html"]);
  }
}

function modal_message(title, message){
  var html = $('<div id="modal_message" class="modal hide">' + 
    '<div class="modal-header"><h3>' + title + '</h3></div>'+
    '<div class="modal-body">'+ message +'</div>'+
    '<div class="modal-footer"></div>'+
    '</div>');
  $(document).append(html)
  html.modal('show');
}

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

function flatten_serialized_array(arr){
  var r = {};
  $.each(arr, function(index, value){
    r[value.name] = value.value
  })
  return r
}
