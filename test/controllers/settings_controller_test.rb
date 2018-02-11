require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
  
    get login_path
    post login_path, params: { session: { password: ENV['TELECONTACT_PASSWORD'] } }

  
    @setting = settings(:one)
  end


  test "should show setting" do
    get settings_path
    assert_response :success
  end

  test "should get edit" do
    get '/settings/edit'
    assert_response :success
  end

  test "should update setting" do
    patch '/settings/edit', params: { setting: { callcount: @setting.callcount, sipnames: @setting.sipnames } }
    assert_redirected_to settings_path
  end

end
