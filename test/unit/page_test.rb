require 'test_helper'

class PageTest < ActiveSupport::TestCase

  test "should find by url" do
    assert Page.find_by_url_or_id!("1")
    assert Page.find_by_url_or_id!("goggles")
    assert Page.find_by_url_or_id!("goggles/they-do-nothing")
    assert_raises(ActiveRecord::RecordNotFound){ Page.find_by_url_or_id!("9001") }
    assert_raises(ActiveRecord::RecordNotFound){ Page.find_by_url_or_id!("non-existent-record") }
  end
end