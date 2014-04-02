User.destroy_all

temp_password = "123"

User.create([
  {
    name: Name.new(
      prefix: "Mr.",
      given: "Joe",
      family: "Blow"
    ),
    email: "joe@example.com",
    password: temp_password,
    password_confirmation: temp_password
  },
  {
    name: Name.new(
      prefix: "Ms.",
      given: "Betty",
      middle: "B.",
      family: "Boop"
    ),
    email: "betty@example.com",
    password: temp_password,
    password_confirmation: temp_password
  },
  {
    name: Name.new(
      prefix: "Dr.",
      given: "Timothy",
      family: "Leary",
      suffix: "Ph.D."
    ),
    email: "tim@example.com",
    password: temp_password,
    password_confirmation: temp_password
  }
])
