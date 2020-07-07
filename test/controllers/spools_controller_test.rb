require 'test_helper'

class SpoolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spool = spools(:one)
  end

  test "should get index" do
    get spools_url
    assert_response :success
  end

  test "should get new" do
    get new_spool_url
    assert_response :success
  end

  test "should create spool" do
    assert_difference('Spool.count') do
      post spools_url, params: { spool: { answer_id: @spool.answer_id } }
    end

    assert_redirected_to spool_url(Spool.last)
  end

  test "should show spool" do
    get spool_url(@spool)
    assert_response :success
  end

  test "should get edit" do
    get edit_spool_url(@spool)
    assert_response :success
  end

  test "should update spool" do
    patch spool_url(@spool), params: { spool: { answer_id: @spool.answer_id } }
    assert_redirected_to spool_url(@spool)
  end

  test "should destroy spool" do
    assert_difference('Spool.count', -1) do
      delete spool_url(@spool)
    end

    assert_redirected_to spools_url
  end
end
