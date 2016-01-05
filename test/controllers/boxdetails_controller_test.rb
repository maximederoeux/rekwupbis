require 'test_helper'

class BoxdetailsControllerTest < ActionController::TestCase
  setup do
    @boxdetail = boxdetails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boxdetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boxdetail" do
    assert_difference('Boxdetail.count') do
      post :create, boxdetail: { article_id: @boxdetail.article_id, box_article_quantity: @boxdetail.box_article_quantity, box_id: @boxdetail.box_id }
    end

    assert_redirected_to boxdetail_path(assigns(:boxdetail))
  end

  test "should show boxdetail" do
    get :show, id: @boxdetail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boxdetail
    assert_response :success
  end

  test "should update boxdetail" do
    patch :update, id: @boxdetail, boxdetail: { article_id: @boxdetail.article_id, box_article_quantity: @boxdetail.box_article_quantity, box_id: @boxdetail.box_id }
    assert_redirected_to boxdetail_path(assigns(:boxdetail))
  end

  test "should destroy boxdetail" do
    assert_difference('Boxdetail.count', -1) do
      delete :destroy, id: @boxdetail
    end

    assert_redirected_to boxdetails_path
  end
end
