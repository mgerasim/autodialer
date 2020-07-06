require 'test_helper'

class OutgoingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outgoing = outgoings(:one)
  end

  test "should get index" do
    get outgoings_url
    assert_response :success
  end

  test "should get new" do
    get new_outgoing_url
    assert_response :success
  end

  test "should create outgoing" do
    assert_difference('Outgoing.count') do
      post outgoings_url, params: { outgoing: { telephone: @outgoing.telephone } }
    end

    assert_redirected_to outgoing_url(Outgoing.last)
  end

  test "should show outgoing" do
    get outgoing_url(@outgoing)
    assert_response :success
  end

  test "should get edit" do
    get edit_outgoing_url(@outgoing)
    assert_response :success
  end

  test "should update outgoing" do
    patch outgoing_url(@outgoing), params: { outgoing: { telephone: @outgoing.telephone } }
    assert_redirected_to outgoing_url(@outgoing)
  end

  test "should destroy outgoing" do
    assert_difference('Outgoing.count', -1) do
      delete outgoing_url(@outgoing)
    end

    assert_redirected_to outgoings_url
  end
end
