require 'test_helper'

class SortingDetailsControllerTest < ActionController::TestCase
  setup do
    @sorting_detail = sorting_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sorting_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sorting_detail" do
    assert_difference('SortingDetail.count') do
      post :create, sorting_detail: { article_id: @sorting_detail.article_id, box_qtty: @sorting_detail.box_qtty, broken: @sorting_detail.broken, clean: @sorting_detail.clean, handling: @sorting_detail.handling, pile_qtty: @sorting_detail.pile_qtty, sorting_id: @sorting_detail.sorting_id, unit_qtty: @sorting_detail.unit_qtty, very_dirty: @sorting_detail.very_dirty }
    end

    assert_redirected_to sorting_detail_path(assigns(:sorting_detail))
  end

  test "should show sorting_detail" do
    get :show, id: @sorting_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sorting_detail
    assert_response :success
  end

  test "should update sorting_detail" do
    patch :update, id: @sorting_detail, sorting_detail: { article_id: @sorting_detail.article_id, box_qtty: @sorting_detail.box_qtty, broken: @sorting_detail.broken, clean: @sorting_detail.clean, handling: @sorting_detail.handling, pile_qtty: @sorting_detail.pile_qtty, sorting_id: @sorting_detail.sorting_id, unit_qtty: @sorting_detail.unit_qtty, very_dirty: @sorting_detail.very_dirty }
    assert_redirected_to sorting_detail_path(assigns(:sorting_detail))
  end

  test "should destroy sorting_detail" do
    assert_difference('SortingDetail.count', -1) do
      delete :destroy, id: @sorting_detail
    end

    assert_redirected_to sorting_details_path
  end
end
