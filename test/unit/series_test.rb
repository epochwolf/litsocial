require 'test_helper'

class SeriesTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Story will save a story series" do
    title = "Story will save a story series"
    s = Story.new
    s.assign_attributes(
      {
        user: users(:one), 
        title: title, 
        contents: 'some text', 
        series_title: title
      }, 
      without_protection: true
    )
    assert s.save, "Story did not save"
    assert s.series_title.nil?, "Callback not run"  
    assert Series.find_by_title(title), "Series not found"
  end
end
