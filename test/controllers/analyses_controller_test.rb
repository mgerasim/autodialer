require 'test_helper'

class AnalysesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @analysis = analyses(:one)
  end

  test "should get index" do
    get analyses_url
    assert_response :success
  end

  test "should get new" do
    get new_analysis_url
    assert_response :success
  end

  test "should create analysis" do
    assert_difference('Analysis.count') do
      post analyses_url, params: { analysis: { answer_count: @analysis.answer_count, employee_active_count: @analysis.employee_active_count, outgoing_count: @analysis.outgoing_count, setting_trunk_active_count: @analysis.setting_trunk_active_count, trunk_enable_count: @analysis.trunk_enable_count } }
    end

    assert_redirected_to analysis_url(Analysis.last)
  end

  test "should show analysis" do
    get analysis_url(@analysis)
    assert_response :success
  end

  test "should get edit" do
    get edit_analysis_url(@analysis)
    assert_response :success
  end

  test "should update analysis" do
    patch analysis_url(@analysis), params: { analysis: { answer_count: @analysis.answer_count, employee_active_count: @analysis.employee_active_count, outgoing_count: @analysis.outgoing_count, setting_trunk_active_count: @analysis.setting_trunk_active_count, trunk_enable_count: @analysis.trunk_enable_count } }
    assert_redirected_to analysis_url(@analysis)
  end

  test "should destroy analysis" do
    assert_difference('Analysis.count', -1) do
      delete analysis_url(@analysis)
    end

    assert_redirected_to analyses_url
  end
end
