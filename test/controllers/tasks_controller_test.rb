require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    
    @uploaded_file = ActionDispatch::Http::UploadedFile.new({
      :tempfile => File.new(Rails.root.join("test/fixtures/files/contacts.txt"))
    })

    @task = tasks(:one)
  end

  test "Форма Задания должна иметь заголовок Задания | Telecontact" do
    get tasks_url
    assert_response :success
    assert_select "title", "Задания | Telecontact"
  end

  test "should get new" do
    get new_task_url
    assert_response :success
    assert_select "title", "Новое задание | Telecontact"
  end

  test "should create task" do
    assert_difference('Task.count') do
      file = Rack::Test::UploadedFile.new(Rails.root.join("test/fixtures/files/contacts.txt"), "plain/text")
      post tasks_url, params: { task: { name: 'Test', :csv_upload => file  } }
      #post :create, :task => {:name => "Test"}
    end

    assert_redirected_to task_url(Task.last)
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

 # test "should update task" do
 #   patch task_url(@task), params: { task: { name: @task.name } }
 #   assert_redirected_to task_url(@task)
 # end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
