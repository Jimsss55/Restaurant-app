module LoginMacros
  def login_request(user)
    post "/users/sign_in", params: { user: { email: user.email, password: user.password } }
  end
end
