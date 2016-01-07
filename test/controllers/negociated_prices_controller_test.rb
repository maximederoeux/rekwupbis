require 'test_helper'

class NegociatedPricesControllerTest < ActionController::TestCase
  setup do
    @negociated_price = negociated_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:negociated_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create negociated_price" do
    assert_difference('NegociatedPrice.count') do
      post :create, negociated_price: { article_id: @negociated_price.article_id, client_id: @negociated_price.client_id, deposit_price: @negociated_price.deposit_price, handwash_price: @negociated_price.handwash_price, tab_price: @negociated_price.tab_price, washing_price: @negociated_price.washing_price }
    end

    assert_redirected_to negociated_price_path(assigns(:negociated_price))
  end

  test "should show negociated_price" do
    get :show, id: @negociated_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @negociated_price
    assert_response :success
  end

  test "should update negociated_price" do
    patch :update, id: @negociated_price, negociated_price: { article_id: @negociated_price.article_id, client_id: @negociated_price.client_id, deposit_price: @negociated_price.deposit_price, handwash_price: @negociated_price.handwash_price, tab_price: @negociated_price.tab_price, washing_price: @negociated_price.washing_price }
    assert_redirected_to negociated_price_path(assigns(:negociated_price))
  end

  test "should destroy negociated_price" do
    assert_difference('NegociatedPrice.count', -1) do
      delete :destroy, id: @negociated_price
    end

    assert_redirected_to negociated_prices_path
  end
end
