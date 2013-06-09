require 'test_helper'

class TimeRecordsControllerTest < ActionController::TestCase
  setup do
    @time_record = time_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_record" do
    assert_difference('TimeRecord.count') do
      post :create, time_record: { end_time: @time_record.end_time, pause_time: @time_record.pause_time, start_time: @time_record.start_time, trello_board_id: @time_record.trello_board_id, user_id: @time_record.user_id }
    end

    assert_redirected_to time_record_path(assigns(:time_record))
  end

  test "should show time_record" do
    get :show, id: @time_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_record
    assert_response :success
  end

  test "should update time_record" do
    patch :update, id: @time_record, time_record: { end_time: @time_record.end_time, pause_time: @time_record.pause_time, start_time: @time_record.start_time, trello_board_id: @time_record.trello_board_id, user_id: @time_record.user_id }
    assert_redirected_to time_record_path(assigns(:time_record))
  end

  test "should destroy time_record" do
    assert_difference('TimeRecord.count', -1) do
      delete :destroy, id: @time_record
    end

    assert_redirected_to time_records_path
  end
end
