require 'test_helper'

class AnalysisControllerTest < ActionDispatch::IntegrationTest
  test "should get answers" do
    get analysis_answers_url
    assert_response :success
  end

end
