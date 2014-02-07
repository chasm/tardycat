User.destroy_all

User.create([
  { email: "joe@example.com" },
  { email: "betty@example.com" },
  { email: "tim@example.com" }
])