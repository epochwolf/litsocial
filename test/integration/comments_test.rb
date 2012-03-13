require "integration_test_helper"


class CommentsTest < CapybaraTest
  fixtures :all

  test "Create a new comment" do
    sign_in(:two)
    visit '/stories/1'
    assert page.has_content?('AHopefullyUniqueStringForAStory'), "Story text shows up"
    assert page.has_no_content?('AHopefullyUniqueStringForAComment'), "Comment doesn't show up"
    
    
    assert page.has_css?('div.modal#comment_dialog'), "Modal dialog exists"
    assert !find('#comment_dialog').visible?, "Modal dialog is closed"
    #assert page.has_no_css?('div.modal.in#comment_dialog', "Modal dialog is not visible")
    assert page.has_css?('div#comments'), "Comments area exists"
    
    click_link "Leave a comment"
    assert find('#comment_dialog').visible?, "Modal dialog is visible"
    
    page.execute_script("CKEDITOR.instances['comment_form_contents'].setData('AHopefullyUniqueStringForAComment');")
    
    within '#comment_form' do
      click_button "Submit"
    end
    
    assert !find('#comment_dialog').visible?, "Modal dialog is closed"
    assert page.has_content?('AHopefullyUniqueStringForAComment'), "Comment shows up"
  end
  
  # test "Reply to a comment" do
  #   assert false, "Not Implemented"
  # end
  
end