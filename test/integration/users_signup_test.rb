require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  # 無効なユーザー登録に対するテスト
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "foo" } }
      end
    assert_template 'users/new'
  end
  
  # 有効なユーザー登録に対するテスト
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "example@railstutorial.com",
                                         password: "password",
                                         password_confirmation: "password" } }
      end
      follow_redirect!
      assert_template 'users/show'
      assert is_logged_in?
  end
  
end
