require 'test_helper'

class DialplansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dialplan = dialplans(:one)
  end

  test "should get index" do
    get dialplans_url
    assert_response :success
  end

  test "should get new" do
    get new_dialplan_url
    assert_response :success
  end

  test "should create dialplan" do
    assert_difference('Dialplan.count') do
      post dialplans_url, params: { dialplan: { name: @dialplan.name, title: @dialplan.title } }
    end

    assert_redirected_to dialplan_url(Dialplan.last)
  end

  test "should show dialplan" do
    get dialplan_url(@dialplan)
    assert_response :success
  end

  test "should get edit" do
    get edit_dialplan_url(@dialplan)
    assert_response :success
  end

  test "should update dialplan" do
    patch dialplan_url(@dialplan), params: { dialplan: { name: @dialplan.name, title: @dialplan.title } }
    assert_redirected_to dialplan_url(@dialplan)
  end

  test "should destroy dialplan" do
    assert_difference('Dialplan.count', -1) do
      delete dialplan_url(@dialplan)
    end

    assert_redirected_to dialplans_url
  end
end
