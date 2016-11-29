if Sinatra::Application.environment == "test"
  puts "seed test"
  user = User.new({
    username: "admin",
    email: "bs@example.com",
  })
  user.password = "password"
  user.save
else
  def seed
    user = User.new({
      username: "admin",
      email: "bs@example.com",
    })
    user.password = "password"
    user.save
  end
end