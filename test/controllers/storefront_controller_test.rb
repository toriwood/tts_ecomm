require 'test_helper'

class StorefrontControllerTest < ActionController::TestCase
  test "should get all_items" do
    get :all_items
    assert_response :success
  end

  test "should get items_by_category" do
    get :items_by_category
    assert_response :success
  end

  test "should get items_by_price" do
    get :items_by_price
    assert_response :success
  end

end
