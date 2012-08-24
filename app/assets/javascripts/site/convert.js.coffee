$ ->
  $("#word_doc_uploader.modal form").on 'submit', ->
    $('#word_doc_uploader').modal('hide')
    modal_message('Please wait', 'Uploading your document for conversion')