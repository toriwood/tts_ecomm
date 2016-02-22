require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get power" do
    get :power
    assert_response :success
  end

end
