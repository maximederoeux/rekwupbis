require 'test_helper'

class ReportingControllerTest < ActionController::TestCase
  test "should get attendances" do
    get :attendances
    assert_response :success
  end

  test "should get statistics" do
    get :statistics
    assert_response :success
  end

end
