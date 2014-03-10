User.destroy_all

temp_password = "123"

User.create([
  {
    email: "joe@example.com",
    password: temp_password,
    password_confirmation: temp_password
  },
  {
    email: "betty@example.com",
    password: temp_password,
    password_confirmation: temp_password
  },
  {
    email: "tim@example.com",
    password: temp_password,
    password_confirmation: temp_password
  }
])