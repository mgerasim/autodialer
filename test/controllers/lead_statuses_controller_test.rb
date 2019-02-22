require 'test_helper'

class LeadStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lead_status = lead_statuses(:one)
  end

  test "should get index" do
    get lead_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_lead_status_url
    assert_response :success
  end

  test "should create lead_status" do
    assert_difference('LeadStatus.count') do
      post lead_statuses_url, params: { lead_status: { image: @lead_status.image, name: @lead_status.name, title: @lead_status.title } }
    end

    assert_redirected_to lead_status_url(LeadStatus.last)
  end

  test "should show lead_status" do
    get lead_status_url(@lead_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_lead_status_url(@lead_status)
    assert_response :success
  end

  test "should update lead_status" do
    patch lead_status_url(@lead_status), params: { lead_status: { image: @lead_status.image, name: @lead_status.name, title: @lead_status.title } }
    assert_redirected_to lead_status_url(@lead_status)
  end

  test "should destroy lead_status" do
    assert_difference('LeadStatus.count', -1) do
      delete lead_status_url(@lead_status)
    end

    assert_redirected_to lead_statuses_url
  end
end
