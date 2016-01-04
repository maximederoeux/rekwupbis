require 'test_helper'

class BoxesControllerTest < ActionController::TestCase
  setup do
    @box = boxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create box" do
    assert_difference('Box.count') do
      post :create, box: { box_detail_id: @box.box_detail_id, box_name: @box.box_name, box_regular: @box.box_regular, box_type: @box.box_type }
    end

    assert_redirected_to box_path(assigns(:box))
  end

  test "should show box" do
    get :show, id: @box
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @box
    assert_response :success
  end

  test "should update box" do
    patch :update, id: @box, box: { box_detail_id: @box.box_detail_id, box_name: @box.box_name, box_regular: @box.box_regular, box_type: @box.box_type }
    assert_redirected_to box_path(assigns(:box))
  end

  test "should destroy box" do
    assert_difference('Box.count', -1) do
      delete :destroy, id: @box
    end

    assert_redirected_to boxes_path
  end
end
