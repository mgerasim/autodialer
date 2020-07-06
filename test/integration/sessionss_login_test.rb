require 'test_helper'

class SessionssLoginTest < ActionDispatch::IntegrationTest
  test "Авторизация с неверным паролем имеет сообщение об ошибке" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { password: "aa" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "Авторизация с верным паролем" do
    get login_path
    post login_path, params: { session: { password: ENV['TELECONTACT_PASSWORD'] } }
    assert_redirected_to tasks_path
    follow_redirect!
    assert_template 'tasks/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path

    get login_path

    assert_redirected_to tasks_path
    follow_redirect!
    assert_template 'tasks/index'

  end
end
