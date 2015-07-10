# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
admin = User.create(
  { uid: "admin@fitbird.com", provider: "email", email: "admin@fitbird.com", password: "Test1234" })

coaches = User.create([
  { uid: "coach1@fitbird.com", provider: "email", email: "coach1@fitbird.com", password: "Test1234" },
  { uid: "coach2@fitbird.com", provider: "email", email: "coach2@fitbird.com", password: "Test1234" }]);

users = User.create([
  { uid: "user1@fitbird.com", provider: "email", email: "user1@fitbird.com", password: "Test1234" },
  { uid: "user2@fitbird.com", provider: "email", email: "user2@fitbird.com", password: "Test1234" }]);

roles = Role.create([
  { name: "Administrator", uniquable_name: "administrator" },
  { name: "Coach", uniquable_name: "coach" },
  { name: "User", uniquable_name: "user" }]);

admin.roles << Role.where(uniquable_name: "administrator")

coaches.each do |user|
  user.roles << Role.where(uniquable_name: "coach")
end

users.each do |user|
  user.roles << Role.where(uniquable_name: "user")
end
