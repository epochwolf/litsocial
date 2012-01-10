
function copy_text_from_iframe(target, text_to_copy){
  console.log("copy_text_from_iframe('"+target+"', '"+text_to_copy+"')");
  stop_modal_spinner();
  $(target).val(text_to_copy);
}