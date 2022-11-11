class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "user logout" do
    @user = User.create(username: "joaco", password: "password")
    post login_path, params: {session: {username: @user.username, password: "password" }}
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
