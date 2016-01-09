require 'test_helper'

class OfferArticlesControllerTest < ActionController::TestCase
  setup do
    @offer_article = offer_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_article" do
    assert_difference('OfferArticle.count') do
      post :create, offer_article: { article_id: @offer_article.article_id, offer_id: @offer_article.offer_id, quantity: @offer_article.quantity }
    end

    assert_redirected_to offer_article_path(assigns(:offer_article))
  end

  test "should show offer_article" do
    get :show, id: @offer_article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer_article
    assert_response :success
  end

  test "should update offer_article" do
    patch :update, id: @offer_article, offer_article: { article_id: @offer_article.article_id, offer_id: @offer_article.offer_id, quantity: @offer_article.quantity }
    assert_redirected_to offer_article_path(assigns(:offer_article))
  end

  test "should destroy offer_article" do
    assert_difference('OfferArticle.count', -1) do
      delete :destroy, id: @offer_article
    end

    assert_redirected_to offer_articles_path
  end
end
