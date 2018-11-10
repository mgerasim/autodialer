require 'test_helper'

class ConfigurationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @configuration = configurations(:one)
  end

  test "should get index" do
    get configurations_url
    assert_response :success
  end

  test "should get new" do
    get new_configuration_url
    assert_response :success
  end

  test "should create configuration" do
    assert_difference('Configuration.count') do
      post configurations_url, params: { configuration: { is_answer_supported: @configuration.is_answer_supported, is_attempt_supported: @configuration.is_attempt_supported, is_google_integrated: @configuration.is_google_integrated, is_outgoing_deleted: @configuration.is_outgoing_deleted, is_outgoing_table_showed: @configuration.is_outgoing_table_showed, password_encrypted: @configuration.password_encrypted } }
    end

    assert_redirected_to configuration_url(Configuration.last)
  end

  test "should show configuration" do
    get configuration_url(@configuration)
    assert_response :success
  end

  test "should get edit" do
    get edit_configuration_url(@configuration)
    assert_response :success
  end

  test "should update configuration" do
    patch configuration_url(@configuration), params: { configuration: { is_answer_supported: @configuration.is_answer_supported, is_attempt_supported: @configuration.is_attempt_supported, is_google_integrated: @configuration.is_google_integrated, is_outgoing_deleted: @configuration.is_outgoing_deleted, is_outgoing_table_showed: @configuration.is_outgoing_table_showed, password_encrypted: @configuration.password_encrypted } }
    assert_redirected_to configuration_url(@configuration)
  end

  test "should destroy configuration" do
    assert_difference('Configuration.count', -1) do
      delete configuration_url(@configuration)
    end

    assert_redirected_to configurations_url
  end
end
