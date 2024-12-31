require 'json'
require_relative 'libs/utlis'

 $db = nil # Instaniate dummy DB

File.open("db.json", "r") do |file|
  $db = JSON.parse(file.read)
  # puts $db
end

# puts $db['Users']["1"], $db['Users']["1"]["acctPasscode"]

# for user in $db["Users"]
# $db['Users'].each do |user|
  # puts user
# puts $db["Users"].inspect
# end

def welcome()
  # Method to welcome Users
  puts ""
  puts "======================================"
  puts "Welcome to Wema Bank!\n\n".upcase()
  puts "======================================="
  puts "What would you like to do today?"
  puts "[1] Open an account"
  puts "[2] Login to your account"
  puts "[3] Customer Care"
  puts "[4] Nearby Banks"

  print "\n==> Enter a response (e.g: 1): "
  response = gets().chomp().to_s
  # verify User's input
  case response
  when "1"
    return createAccount()

  when "2"
    return loginUser()

  when "3"
    return customerCare()

  when '4'
    return nearbyBanks()

  else
    puts "Oops, Looks like you entered an invalid option. Please try again"
    welcome()
  end

end

def email_exists?(email);
  $db['Users'].each do |id, user|
    return true if user['email'] == email
  end
  false
end

def verify_phonenumber()
  loop do
    print "==> Enter your Phone Number: "
    number = gets.chomp().to_s

    if !number.match(/^(\+\d+)(\d+)$/)
      puts "==> ERROR: Please enter your number with your country code!"
    else
      country_code = $1
      phone_number = $2

      $db["Users"].each do |id, user|
        if phone_number != user["phone_number"]
          return phone_number, country_code
        else
          puts "ERROR: This Phone Number [#{phone_number}] already exists!. Enter a different Phone Number"
        end
      end
    end
  end
end
# Function to get User email
def get_email()
  loop do
    print '==> Enter your email address: '
    email = gets.chomp().to_s

    if email.include?("@") && email.include?(".com") # checks if '@' and '.com' are in the email string
      if email_exists?(email)
        puts "Error: Email already exists. Please enter a different email."
      else
        return email # exits and returns email
      end
    else
        puts "Error: Please enter a valid email address!"
    end
  end
end

# Method to create user account
def createAccount();
  puts ""
  puts "========================"
  puts "CREATE A WEMA ACCOUNT"
  puts "========================\n"


  puts "Please carefully enter valid response. Let's get you started!"

  email = get_email()
  phone_number, country_code = verify_phonenumber()


  # response = gets.chomp().to_i

end

# Method to authenticate Users
def loginUser()
  puts ''
  puts "==================================="
  puts "Login in to your account".upcase()
  puts "==================================="
  puts 'Welcome Back, Dear Esteemed Customer'
  puts ''
  print "Enter your Account Number: "
  acctNumber = gets.chomp().to_i
  print "Enter your 4-digt PIN: "
  acctPasscode = gets.chomp().to_i

  if $db['Users']
    $db["Users"].each do |id, user|
      # puts id, id.inspect
      if user["acctNumber"] == acctNumber
        if user["acctPasscode"] == acctPasscode
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


def UserProfile(user_id)
  puts '---------------------------------'
  puts "Hello, #{$db['Users'][user_id]["first_name"]} #{$db['Users'][user_id]["last_name"]}"
end


welcome
