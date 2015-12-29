require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { city: @event.city, comment: @event.comment, country: @event.country, cupcava: @event.cupcava, cupfifty: @event.cupfifty, cupforty: @event.cupforty, cuplitre: @event.cuplitre, cupshot: @event.cupshot, cuptwenty: @event.cuptwenty, cuptwentyfive: @event.cuptwentyfive, cupwine: @event.cupwine, event_end_date: @event.event_end_date, event_name: @event.event_name, event_start_date: @event.event_start_date, expected_pax: @event.expected_pax, last_pax: @event.last_pax, post_code: @event.post_code }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { city: @event.city, comment: @event.comment, country: @event.country, cupcava: @event.cupcava, cupfifty: @event.cupfifty, cupforty: @event.cupforty, cuplitre: @event.cuplitre, cupshot: @event.cupshot, cuptwenty: @event.cuptwenty, cuptwentyfive: @event.cuptwentyfive, cupwine: @event.cupwine, event_end_date: @event.event_end_date, event_name: @event.event_name, event_start_date: @event.event_start_date, expected_pax: @event.expected_pax, last_pax: @event.last_pax, post_code: @event.post_code }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
