require 'test_helper'

class ReturnBoxesControllerTest < ActionController::TestCase
  setup do
    @return_box = return_boxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:return_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create return_box" do
    assert_difference('ReturnBox.count') do
      post :create, return_box: { ctrl_time: @return_box.ctrl_time, ctrler: @return_box.ctrler, delivery_id: @return_box.delivery_id, is_back: @return_box.is_back, is_controlled: @return_box.is_controlled, receptionist: @return_box.receptionist, return_time: @return_box.return_time }
    end

    assert_redirected_to return_box_path(assigns(:return_box))
  end

  test "should show return_box" do
    get :show, id: @return_box
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @return_box
    assert_response :success
  end

  test "should update return_box" do
    patch :update, id: @return_box, return_box: { ctrl_time: @return_box.ctrl_time, ctrler: @return_box.ctrler, delivery_id: @return_box.delivery_id, is_back: @return_box.is_back, is_controlled: @return_box.is_controlled, receptionist: @return_box.receptionist, return_time: @return_box.return_time }
    assert_redirected_to return_box_path(assigns(:return_box))
  end

  test "should destroy return_box" do
    assert_difference('ReturnBox.count', -1) do
      delete :destroy, id: @return_box
    end

    assert_redirected_to return_boxes_path
  end
end
