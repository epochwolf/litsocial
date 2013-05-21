require 'integration_test_helper'

class CapyBookmarkTest < CapyTest
  fixtures :all

  # TODO: Check the page url and response codes. 
  # <elaptics> epochwolf: in rspec with capybara you can do something like:     expect(current_path).to eql(some_path)

  test "Epoch can bookmark" do 
    # Login and look for the bookmarks
    sign_in(users(:epoch))
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert page.has_no_selector?("article.story #bookmark-message"), "I see a bookmark message, it doesn't belong here."

    # Set a bookmark
    bookmark = find('#story-text p[id] i.icon-bookmark.bookmark')
    assert bookmark, "bookmarks missing"
    bookmark.click
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't save"

    # Toggle it, for great justice!
    bookmark.click
    assert page.has_no_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "toggling the bookmark didn't work"
    bookmark.click
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't save a second time"

    # Make sure it's in the user's bookmarks.
    visit '/account/bookmarks'
    assert page.body =~ /EpochsStory/, "Bookmark isn't showing up on the accounts page."
    assert page.body =~ /#paragraph-1/, "Bookmark isn't linked on the accounts page."


    # Reload the page to see if it's still there.
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark"), "bookmarks missing"
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "saved bookmarks missing"
    assert page.has_selector?("article.story #bookmark-message"), "bookmarks message missing"

    # Now we clear the bookmark
    clear_bookmark = find('#clear_bookmark')
    assert clear_bookmark, "missing clear bookmark message"
    clear_bookmark.click
    assert page.has_no_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't clear"

    # Reload the page so we can be sure.
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark"), "bookmarks missing"
    assert page.has_no_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "saved bookmark didn't clear after reload"
    assert page.has_no_selector?("article.story #bookmark-message"), "the bookmark message didn't clear after reload"
  end

  test "Guest can bookmark too" do
    sign_out
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert page.has_no_selector?("article.story #bookmark-message"), "I see a bookmark message, it doesn't belong here."

    # Set a bookmark
    bookmark = find('#story-text p[id] i.icon-bookmark.bookmark')
    assert bookmark, "bookmarks missing"
    bookmark.click
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't save"

    # Toggle it, for great justice!
    bookmark.click
    assert page.has_no_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "toggling the bookmark didn't work"
    bookmark.click
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't save a second time"

    # Skip this for guests... for now. I don't know where I want to add a bookmark list to the UI when the user is logged out.
    # 
    # Make sure it's in the user's bookmarks.
    # visit '/account/bookmarks'
    # assert page.body =~ /EpochsStory/, "Bookmark isn't showing up on the accounts page."
    # assert page.body =~ /#paragraph-1/, "Bookmark isn't linked on the accounts page."


    # Reload the page to see if it's still there.
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark"), "bookmarks missing"
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "saved bookmarks missing"
    assert page.has_selector?("article.story #bookmark-message"), "bookmarks message missing"

    # Now we clear the bookmark
    clear_bookmark = find('#clear_bookmark')
    assert clear_bookmark, "missing clear bookmark message"
    clear_bookmark.click
    assert page.has_no_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't clear"

    # Reload the page so we can be sure.
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark"), "bookmarks missing"
    assert page.has_no_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "saved bookmark didn't clear after reload"
    assert page.has_no_selector?("article.story #bookmark-message"), "the bookmark message didn't clear after reload"
  end 

  test "Import Bookmarks" do 
    sign_out
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert page.has_no_selector?("article.story #bookmark-message"), "I see a bookmark message, it doesn't belong here."

    # Set a bookmark
    bookmark = find('#story-text p[id] i.icon-bookmark.bookmark')
    assert bookmark, "bookmarks missing"
    bookmark.click
    assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't save"

    # Sign in member and import the bookmark.
    visit '/sign_in'
    fill_in 'Name', :with => 'member'
    fill_in 'Password', :with => 'Password'
    click_button 'Sign in'
    assert page.body =~ /Signed in successfully\./, "Sign In Failed"
    assert page.body =~ /Import Bookmarks/, "Not on the import page"
    click_link "Import Bookmarks"
    assert page.body =~ /Your bookmarks have been imported\./, "Bookmarks didn't import"

    # Make sure it's in the user's bookmarks.
    visit '/account/bookmarks'
    assert page.body =~ /EpochsStory/, "Bookmark isn't showing up on the accounts page."
    assert page.body =~ /#paragraph-1/, "Bookmark isn't linked on the accounts page."
  end
end