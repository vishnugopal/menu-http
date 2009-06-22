require File.dirname(__FILE__) + '/test_helper.rb'

require "test/unit"
class MenuHTTPTest < Test::Unit::TestCase
  def setup
  end

  def teardown
  end

  def test_redirect
    expected = ["menu",
     [{"message"=>"Please select an option:"},
      ["pizza", "Pizza"],
      ["coconut", "Coconut"],
      ["loop", "Loop for Fun!"],
      ["url", "Twitter URL"],
      ["case", "Case check!"]]]
    result = flow_response_for_choices(["index", 3])
    assert_equal(expected, result)
  end
  
  def test_url
    expected = ["message",
     "{\"text\":\"finished analyzing smam\\/ac success rates\",\"favorited\":false,\"user\":{\"statuses_count\":1753,\"profile_sidebar_border_color\":\"131411\",\"description\":\"Founder of CrowdVine\",\"utc_offset\":-28800,\"screen_name\":\"tonystubblebine\",\"created_at\":\"Tue Mar 21 21:01:35 +0000 2006\",\"profile_text_color\":\"000000\",\"followers_count\":6942,\"profile_background_image_url\":\"http:\\/\\/s3.amazonaws.com\\/twitter_production\\/profile_background_images\\/32\\/OTHER-Lista_1280x1024.jpg\",\"url\":\"http:\\/\\/www.stubbleblog.com\\/\",\"name\":\"Tony Stubblebine\",\"notifications\":null,\"time_zone\":\"Pacific Time (US & Canada)\",\"friends_count\":173,\"profile_link_color\":\"0000ff\",\"protected\":false,\"profile_background_tile\":false,\"profile_background_color\":\"0D7CDA\",\"following\":null,\"favourites_count\":23,\"profile_sidebar_fill_color\":\"91FFE9\",\"location\":\"S Knoll Rd &amp; Shayan Ct, St\",\"id\":17,\"verified\":false,\"profile_image_url\":\"http:\\/\\/s3.amazonaws.com\\/twitter_production\\/profile_images\\/14019552\\/profile_normal.jpg\"},\"created_at\":\"Thu Mar 23 00:03:19 +0000 2006\",\"in_reply_to_screen_name\":null,\"truncated\":false,\"in_reply_to_status_id\":null,\"id\":123,\"in_reply_to_user_id\":null,\"source\":\"web\"}"]
    result = flow_response_for_choices(["index", 4])
    assert_equal(expected, result)
  end
  
  def test_case
    expected = ["message","True enough!"]
    result = flow_response_for_choices(["index", 5])
    assert_equal(expected, result)
  end
end
