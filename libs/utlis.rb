require_relative 'crypt'

def email_exists?(email);
  $db['Users'].each do |id, user|
    return true if user['email'] == email
  end
  false
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
        puts "[Error]: Please enter a valid email address!"
    end
  end
end



def verify_phonenumber()
  loop do
    print "==> Enter your Phone Number: "
    number = gets.chomp().to_s

    if !number.match(/^(\+\d+)(\d+)$/)
      puts "*[ERROR]: Please enter your number with your country code!"
    else
      country_code = $1
      phone_number = $2

      $db["Users"].each do |id, user|
        if phone_number != user["phone_number"]
          return phone_number, country_code
        else
          puts "*[ERROR]: This Phone Number [#{phone_number}] already exists!. Enter a different Phone Number"
        end
      end
    end
  end
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
      break # Exit the loop if a valid gender is entered
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

  loop do
    print "Create a 4-digit PIN: "
    pin = gets.chomp().to_i

    print "Retype your 4-digit PIN: "
    confirm_pin = gets.chomp().to_i

    sleep(2)
    puts "Verifying Your PIN, please wait...."
    sleep(3)
    api_response = validatePIN(pin, confirm_pin)

    case api_response
    when true
      # save_user(email, acctNumber, phone_number, country_code, gender, first_name, last_name, middle_name, pin)
      puts "*[SUCCESS] Account Successfully Created, Please don't expose your PIN to anyone. Please proceed to login"
      break
    else
      puts "*[ERROR] PINs do not match, please try again"
    end

  end

end


def save_user(email, acctNumber, phone_number, country_code, gender, first_name, last_name, middle_name, pin);
  
end
