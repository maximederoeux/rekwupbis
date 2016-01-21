require 'test_helper'

class SortingsControllerTest < ActionController::TestCase
  setup do
    @sorting = sortings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sortings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sorting" do
    assert_difference('Sorting.count') do
      post :create, sorting: { end_time: @sorting.end_time, ender: @sorting.ender, return_box_id: @sorting.return_box_id, start_time: @sorting.start_time, starter: @sorting.starter }
    end

    assert_redirected_to sorting_path(assigns(:sorting))
  end

  test "should show sorting" do
    get :show, id: @sorting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sorting
    assert_response :success
  end

  test "should update sorting" do
    patch :update, id: @sorting, sorting: { end_time: @sorting.end_time, ender: @sorting.ender, return_box_id: @sorting.return_box_id, start_time: @sorting.start_time, starter: @sorting.starter }
    assert_redirected_to sorting_path(assigns(:sorting))
  end

  test "should destroy sorting" do
    assert_difference('Sorting.count', -1) do
      delete :destroy, id: @sorting
    end

    assert_redirected_to sortings_path
  end
end
