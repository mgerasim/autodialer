require 'test_helper'

class SipaccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sipaccount = sipaccounts(:one)
  end

  test "should get index" do
    get sipaccounts_url
    assert_response :success
  end

  test "should get new" do
    get new_sipaccount_url
    assert_response :success
  end

  test "should create sipaccount" do
    assert_difference('Sipaccount.count') do
      post sipaccounts_url, params: { sipaccount: { number: @sipaccount.number, password: @sipaccount.password } }
    end

    assert_redirected_to sipaccount_url(Sipaccount.last)
  end

  test "should show sipaccount" do
    get sipaccount_url(@sipaccount)
    assert_response :success
  end

  test "should get edit" do
    get edit_sipaccount_url(@sipaccount)
    assert_response :success
  end

  test "should update sipaccount" do
    patch sipaccount_url(@sipaccount), params: { sipaccount: { number: @sipaccount.number, password: @sipaccount.password } }
    assert_redirected_to sipaccount_url(@sipaccount)
  end

  test "should destroy sipaccount" do
    assert_difference('Sipaccount.count', -1) do
      delete sipaccount_url(@sipaccount)
    end

    assert_redirected_to sipaccounts_url
  end
end
