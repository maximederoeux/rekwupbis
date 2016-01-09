require 'test_helper'

class OfferBoxesControllerTest < ActionController::TestCase
  setup do
    @offer_box = offer_boxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_box" do
    assert_difference('OfferBox.count') do
      post :create, offer_box: { box_id: @offer_box.box_id, offer_id: @offer_box.offer_id, quantity: @offer_box.quantity }
    end

    assert_redirected_to offer_box_path(assigns(:offer_box))
  end

  test "should show offer_box" do
    get :show, id: @offer_box
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer_box
    assert_response :success
  end

  test "should update offer_box" do
    patch :update, id: @offer_box, offer_box: { box_id: @offer_box.box_id, offer_id: @offer_box.offer_id, quantity: @offer_box.quantity }
    assert_redirected_to offer_box_path(assigns(:offer_box))
  end

  test "should destroy offer_box" do
    assert_difference('OfferBox.count', -1) do
      delete :destroy, id: @offer_box
    end

    assert_redirected_to offer_boxes_path
  end
end
