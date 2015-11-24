require 'test_helper'

class SubscriptionControllerTest < ActionController::TestCase
  test "get_subscription_page" do 
    get :index
    assert_response :success
  end
  test "create" do
    post(:create, list: { email: "ktrajchevska@gmail.com", first_name: "Katerina",  last_name: "Trajchevska"})
    assert_response :found
    assert !flash.empty?
  end
end