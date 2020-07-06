require 'test_helper'

class CdrControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cdr_index_url
    assert_response :success
  end

end
