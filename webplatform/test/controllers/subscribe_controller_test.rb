require 'test_helper'

class SubscribeControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "get_subscribe_page" do 
    get :index
    assert_response :success
  end
  test "subscribe" do
    post(:subscribe, list: { email: "ktrajchevska@gmail.com", first_name: "Katerina",  last_name: "Trajchevska"})
    assert_response :found
    assert !flash.empty?
  end
end
