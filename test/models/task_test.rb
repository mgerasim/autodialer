require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @uploaded_file = ActionDispatch::Http::UploadedFile.new({
    :tempfile => File.new(Rails.root.join("test/fixtures/files/contacts.txt"))
})
    @task = Task.new(name: 'Test', csv_upload: @uploaded_file)
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "name should be present" do
    @task.name = "     "
    assert_not @task.valid?
    @task.name = "Test"
    assert @task.valid?
    @task.csv_upload = nil
    assert_not @task.valid?
    @task.csv_upload = @uploaded_file
    assert @task.valid?
  end

  test "name should not be too long" do
    @task.name = "a" * 51
    assert_not @task.valid?
  end

  test "Проверка добавления телефонов при сохранении" do
   @task.save
   assert_equal @task.contacts.count, 2
  end

end
