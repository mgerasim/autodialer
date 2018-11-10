require 'test_helper'

class ConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @config = configs(:one)
  end

  test "should get index" do
    get configs_url
    assert_response :success
  end

  test "should get new" do
    get new_config_url
    assert_response :success
  end

  test "should create config" do
    assert_difference('Config.count') do
      post configs_url, params: { config: { is_answer_supported: @config.is_answer_supported, is_attempt_supported: @config.is_attempt_supported, is_google_integrated: @config.is_google_integrated, is_outgoing_deleted: @config.is_outgoing_deleted, is_outgoing_table_showed: @config.is_outgoing_table_showed, password_encrypted: @config.password_encrypted } }
    end

    assert_redirected_to config_url(Config.last)
  end

  test "should show config" do
    get config_url(@config)
    assert_response :success
  end

  test "should get edit" do
    get edit_config_url(@config)
    assert_response :success
  end

  test "should update config" do
    patch config_url(@config), params: { config: { is_answer_supported: @config.is_answer_supported, is_attempt_supported: @config.is_attempt_supported, is_google_integrated: @config.is_google_integrated, is_outgoing_deleted: @config.is_outgoing_deleted, is_outgoing_table_showed: @config.is_outgoing_table_showed, password_encrypted: @config.password_encrypted } }
    assert_redirected_to config_url(@config)
  end

  test "should destroy config" do
    assert_difference('Config.count', -1) do
      delete config_url(@config)
    end

    assert_redirected_to configs_url
  end
end
