$(document).ready(function(){
  var csrf_token = $('meta[name=csrf-token]').attr('content');
  var csrf_param = $('meta[name=csrf-param]').attr('content');
  var params;
  if (csrf_param !== undefined && csrf_token !== undefined) {
    params = csrf_param + "=" + encodeURIComponent(csrf_token);
  }
  $('.redactor').redactor(
    { "path":"/assets/redactor-rails",
      "autoresize": false,
      "css":"style.css",
      "buttons": [
        'html', '|', 'formatting', '|', 'bold', 'italic', 'deleted', '|',
        'unorderedlist', 'orderedlist', 'outdent', 'indent', '|', 
        'table', 'link', '|', 'alignleft', 'aligncenter', 'alignright', 
        'justify', '|', 'horizontalrule'
      ]
    }
  );
});



