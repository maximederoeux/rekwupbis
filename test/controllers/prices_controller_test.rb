require 'test_helper'

class PricesControllerTest < ActionController::TestCase
  setup do
    @price = prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create price" do
    assert_difference('Price.count') do
      post :create, price: { article_id: @price.article_id, deposit: @price.deposit, handling: @price.handling, handwash: @price.handwash, negociated: @price.negociated, regular: @price.regular, sell: @price.sell, user_id: @price.user_id, valid_from: @price.valid_from, valid_till: @price.valid_till, wash: @price.wash }
    end

    assert_redirected_to price_path(assigns(:price))
  end

  test "should show price" do
    get :show, id: @price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @price
    assert_response :success
  end

  test "should update price" do
    patch :update, id: @price, price: { article_id: @price.article_id, deposit: @price.deposit, handling: @price.handling, handwash: @price.handwash, negociated: @price.negociated, regular: @price.regular, sell: @price.sell, user_id: @price.user_id, valid_from: @price.valid_from, valid_till: @price.valid_till, wash: @price.wash }
    assert_redirected_to price_path(assigns(:price))
  end

  test "should destroy price" do
    assert_difference('Price.count', -1) do
      delete :destroy, id: @price
    end

    assert_redirected_to prices_path
  end
end
