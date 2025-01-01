
def UserProfile(user_id)
  puts '---------------------------------'
  puts "Hello, #{$db['Users'][user_id]["first_name"]} #{$db['Users'][user_id]["last_name"]}"
end
