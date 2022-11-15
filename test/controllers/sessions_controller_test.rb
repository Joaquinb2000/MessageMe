require 'test_helper.rb'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "user logout" do
    @user = User.create(username: "joaco", password: "password")
    login (@user)
    delete logout_path
    assert_redirected_to root_path
  end

  test "only logged user can log out" do
  delete logout_path
  assert_redirected_to login_path
  follow_redirect!
  assert_match "You need to be logged in to perform that action", response.body
  end
end
