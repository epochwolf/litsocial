require 'test_helper'

class KindleHtmlWriterTest < ActiveSupport::TestCase
  fixtures :all

  test "Series renders correctly" do
    series = series("one")
    html = KindleHtml::SeriesWriter.new(series).to_html

    assert_match /EpochsSeries/, html, "can't find series title"
    assert_match /by epochwolf/, html, "can't find author"

    assert_match /EpochsStory1/, html, "can't find story1 title"
    assert_match /MyString1/, html, "can't find story1 contents"

    assert_match /EpochsStory2/, html, "can't find story2 title"
    assert_match /MyString2/, html, "can't find story2 contents"
  end

  test "Story renders correctly" do
    story = stories("epochs_story")
    html = KindleHtml::StoryWriter.new(story).to_html

    assert_match /EpochsStory/, html, "can't find title"
    assert_match /by epochwolf/, html, "can't find author"
    assert_match /MyString/, html, "can't find contents"
  end
end
