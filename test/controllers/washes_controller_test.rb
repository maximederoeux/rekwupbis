require 'test_helper'

class WashesControllerTest < ActionController::TestCase
  setup do
    @wash = washes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:washes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wash" do
    assert_difference('Wash.count') do
      post :create, wash: { end_time: @wash.end_time, return_box_id: @wash.return_box_id, start_time: @wash.start_time, washer: @wash.washer }
    end

    assert_redirected_to wash_path(assigns(:wash))
  end

  test "should show wash" do
    get :show, id: @wash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wash
    assert_response :success
  end

  test "should update wash" do
    patch :update, id: @wash, wash: { end_time: @wash.end_time, return_box_id: @wash.return_box_id, start_time: @wash.start_time, washer: @wash.washer }
    assert_redirected_to wash_path(assigns(:wash))
  end

  test "should destroy wash" do
    assert_difference('Wash.count', -1) do
      delete :destroy, id: @wash
    end

    assert_redirected_to washes_path
  end
end
