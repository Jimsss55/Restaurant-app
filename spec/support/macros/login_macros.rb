module LoginMacros
  def login_request(user)
    post "/users/sign_in.json", params: { user: { email: user.email, password: user.password, remember_me: 0 } }
    # binding.pry
  end
end
