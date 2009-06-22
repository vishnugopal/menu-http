require File.dirname(__FILE__) + '/test_helper.rb'

require "test/unit"
class MenuHTTPTest < Test::Unit::TestCase
  def setup
  end

  def teardown
  end

  def test_redirect
    expected = ["menu", [["pizza", "Pizza"], ["coconut", "Coconut"], ["loop", "Loop for Fun!"]]]
    result = flow_response_for_choices(["index", 3])
    assert_equal(expected, result)
  end
end
