require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:orange)
  end
  
  # Micropostコントローラの認可テスト
  test "should redirected create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end
  
  # Micropostコントローラの認可テスト
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end
  
  # 間違ったユーザーによるマイクロポスト削除に対するテスト
  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end
  
end
