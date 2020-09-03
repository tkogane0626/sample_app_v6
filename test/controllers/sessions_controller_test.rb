require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  # Sessionコントローラのテストで名前付きルートを使うようにする
  test "should get new" do
    get login_path
    assert_response :success
  end

end
