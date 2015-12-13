require 'test_helper'

class MentorProfilesControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
