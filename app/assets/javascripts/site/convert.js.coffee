$ ->
  $("#word_doc_uploader.modal form").on 'submit', ->
    $('#word_doc_uploader').modal('hide')
    modal_message('Sending a ferret...', 'He should be back in just a few seconds, if he doesn\'t get lost.')
    