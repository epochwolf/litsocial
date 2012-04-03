
function copy_text_from_iframe(target, text_to_copy){
  dismiss_modal_message();
  $(target).val(text_to_copy);
}

$(function(){
  $("#word_doc_uploader.modal form").on('submit', function(){
    $('#word_doc_uploader').modal('hide');
    modal_message('Please wait', 'Uploading your document for conversion');
  });
});