require 'test_helper'

class ContactControllerTest < ActionController::TestCase
  test "should get contactus" do
    get :contactus
    assert_response :success
  end

end
