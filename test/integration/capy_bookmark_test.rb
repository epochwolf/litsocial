require 'integration_test_helper'

class CapyBookmarkTest < CapyTest
  fixtures :all

  test "Epoch can see bookmarks" do 
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
    # bookmark.click
    # assert page.has_no_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "toggling the bookmark didn't work"
    # bookmark.click
    # assert page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark.bookmark-saved"), "bookmark didn't save a second time"

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

  test "Guest can't see bookmarks" do
    sign_out
    visit '/stories/1'
    assert page.has_selector?("#story-text"), "story-text missing"
    assert page.has_selector?("#story-text p[id]"), "story missing paragraph ids"
    assert !page.has_selector?("#story-text p[id] i.icon-bookmark.bookmark"), "bookmarks shouldn't be visible"
  end 
end