require 'integration_test_helper'

class CapyCommentsTest < CapyTest
  fixtures :all

  # TODO: Check the page url and response codes. 
  # <elaptics> epochwolf: in rspec with capybara you can do something like:     expect(current_path).to eql(some_path)

  test "Epoch can comment" do 
    # Login and look for the bookmarks
    sign_in(users(:epoch))
    visit '/stories/1'
    assert page.has_selector?("form#new_comment"), "comment form is missing"

    ids = Comment.uncached{ Comment.pluck(:id) }
    assert_difference "Comment.count" do 
      within "form#new_comment" do 
        fill_in_redactor "form#new_comment textarea", "<p>This is a very special comment. :)</p>"
        click_button "Create Comment"
      end

      assert page.has_no_selector?("form#new_comment"), "comment form is showing up, didn't save?"
    end
    # I do this so I can grab the id of the comment that was created. I don't know how else to do this. :(
    new_ids = Comment.uncached{ Comment.pluck(:id) }
    assert comment_id = (new_ids - ids).first, "couldn't find the id in the database for the new comment."

    assert page.has_selector?("#comment-#{comment_id}"), "couldn't find new comment on the page!"
    assert page.find("#comment-#{comment_id} p", :text => 'This is a very special comment. :)'), "couldn't find new comment on the page!"

    within "#comment-#{comment_id} .meta" do 
      click_link "edit"
    end
    assert page.has_selector?("#comment-#{comment_id} form"), "couldn't find the comment edit form."

    within "#comment-#{comment_id} form" do 
      fill_in_redactor "#comment-#{comment_id} textarea", "<p>This is a very unhappy comment. :(</p>"
      click_button "Update Comment"
    end
    assert page.has_no_selector?("#comment-#{comment_id} form"), "comment edit form is showing up, didn't save?"
    assert page.has_selector?("#comment-#{comment_id}"), "couldn't find the updated comment on the page!"
    assert page.find("#comment-#{comment_id} p", :text => 'This is a very unhappy comment. :('), "couldn't find the updated comment on the page!"

    within "#comment-#{comment_id} .meta" do 
      click_link "delete"
    end
    assert page.has_selector?("#comment-#{comment_id}"), "couldn't find the deleted comment on the page!"
    assert page.has_no_selector?("#comment-#{comment_id} p", :text => 'This is a very unhappy comment. :('), "Comment didn't delete."
    assert page.has_selector?("#comment-#{comment_id} p", :text => 'Comment by epochwolf deleted'), "Comment isn't showing proper delete message"
  end

  test "Guest can't comment" do
    sign_out
    visit '/stories/1'
    assert page.has_no_selector?("form#new_comment"), "comment form is showing up"
  end
end