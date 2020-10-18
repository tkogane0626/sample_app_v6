require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", 
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end
  
  # 有効なUserかどうかのテスト
  test "should be valid" do
    assert @user.valid?
  end
  
  # name属性のバリデーションに対するテスト
  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end
  
  # email属性のバリデーションに対するテスト
  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end
  
  # nameの長さの検証に対するテスト
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  # emailの長さに対するテスト
  test "email should not be too long" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  # 有効なメールフォーマットを検証するテスト
  test "email validation should accept valid address" do
    valid_address = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_address.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  # メールフォーマットの検証に対するテスト
  test "email validation should reject invalid address" do
    invalid_address = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_address.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  # 重複するメールアドレスを拒否するテスト
  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  
  # パスワードの空文字を検証するテスト
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  # パスワードの文字数を検証するテスト
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  # ダイジェストが存在しない場合のauthenticated?のテスト
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
end
