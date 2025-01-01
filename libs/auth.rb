

def login(acctNumber, acctPasscode);

  if $db['Users']
    $db["Users"].each do |id, user|
      # puts id, id.inspect
      if user["acctNumber"] == acctNumber
        if user["acctPasscode"] == acctPasscode
          # return id
          return UserProfile(user_id=id) # Exit the method after successful login
        else
          puts "Incorrect PIN or Account Details"
          return loginUser() # Recursive call for retrying login
        end
      end
    end
  end
  # If no matching account is found
  puts "Incorrect PIN or Account Details"
  loginUser() # Recursive call for retrying login
end
