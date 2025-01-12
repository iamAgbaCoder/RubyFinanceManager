require 'json'
require_relative "../db/users"
require_relative "signin"
require_relative "utils"
require_relative "auth"
require_relative '../account/profile'

def login(acctNumber, acctPasscode);

  if $db['Users']
    $db["Users"].each do |id, user|
      # puts id, id.inspect
      if user["acctNumber"] == acctNumber.to_i
        if user["acctPasscode"] == acctPasscode.to_i
          # return id
          return UserProfile(user_id=id) # Exit the method after successful login
        else
          puts "Incorrect PIN or Account Details"
          return loginUserView() # Recursive call for retrying login
        end
      end
    end
  end
  # If no matching account is found
  puts "Incorrect PIN or Account Details"
  loginUserView() # Recursive call for retrying login
end


# Define a method to write user profiles into the JSON file

def save_user(db_path = "db/db.json", user)
  # Check if the database file exists
  if File.exist?(db_path)
    # Read the existing data from the file
    file = File.read(db_path)
    db = JSON.parse(file, symbolize_names: true)
  else
    # Create a new database structure if the file doesn't exist
    db = { Users: {} }
  end

  # Generate a unique ID for the user
  # new_user_id = db[:Users].keys.map(&:to_i).max.to_i + 1
  new_user_id = db[:Users].keys.map { |key| key.to_s.to_i }.max.to_i + 1


  # Add the new user profile
  db[:Users][new_user_id] = user

  # Write the updated database back to the file
  File.open(db_path, 'w') do |f|
    f.write(JSON.pretty_generate(db))
  end

  puts "*[SUCCESS] Account Successfully Created, Please don't disclose your PIN to anyone."
  sleep(2)
  puts "Creating User Profile, processing....."
  sleep(3)
  system("cls") | system("clear") # clears terminal screen and loads the next page

  puts """
    =====================================
           USER ACCOUNT PROFILE
    =====================================
    ACCOUNT NAME: #{user[:first_name]} #{user[:middle_name]} #{user[:last_name]}
    ACCOUNT NUMBER: #{user[:acctNumber]}
    EMAIL: #{user[:email]}
    PHONE NUMBER: #{user[:phone_number]}
    GENDER: #{user[:gender]}
  """
  sleep(5)
  puts "Redirecting you to the homepage..."
  sleep(4)
  puts "Almost done, Please wait..."
  sleep(3)
  system("cls") | system("clear") # clears terminal screen and loads the signup page
  # Call the welcome method, ensure it's accessible
  welcome()
end


def setup_profile(email, phone_number, country_code)
  print "==> Enter your First Name: "
  first_name = gets.chomp.to_s.capitalize
  print "==> Enter your Middle Name: "
  middle_name = gets.chomp.to_s.capitalize
  print "==> Enter your Last Name: "
  last_name = gets.chomp.to_s.capitalize

  gender = nil
  loop do
    print '==> What is your gender [Male, Female, Custom]: '
    gender = gets.chomp.to_s.capitalize

    case gender
    when "Male", "Female", "Custom"
      break
    else
      puts "*[ERROR] Please type a valid gender!"
    end
  end

  puts "Setting up profile, please wait....."
  sleep(3)
  puts "Generating Account Number....."
  sleep(3)

  acctNumber = generate_account_number()
  puts "*[SUCCESS] Congrats #{first_name} #{last_name}! Your account number is #{acctNumber}"

  pin = nil
  confirm_pin = nil # Declare confirm_pin outside the loop
  loop do
    print "==> Create a 4-digit PIN: "
    pin = gets.chomp()

    print "==> Retype your 4-digit PIN: "
    confirm_pin = gets.chomp()


    sleep(3)
    puts "Verifying Your PIN, please wait...."
    # case pin && confirm_pin
    if pin.length() == 4 && confirm_pin.length() == 4
      sleep(3)
      api_response = validatePIN(pin, confirm_pin)
      if api_response == true
        break
      else
        puts "*[ERROR] PINs do not match, please try again"
      end
    else
      puts "*[ERROR] PINs can not be longer or shorter than 4 in length"
    end
  end

  # puts "Confirm PIN: #{confirm_pin}, Email: #{email}"

  user = {
    "email": email,
    "acctNumber": acctNumber.to_i,
    "acctPasscode": confirm_pin.to_i,
    "country_code": country_code,
    "phone_number": phone_number,
    "gender": gender,
    "first_name": first_name,
    "middle_name": middle_name,
    "last_name": last_name
  }
  save_user(user)
end
