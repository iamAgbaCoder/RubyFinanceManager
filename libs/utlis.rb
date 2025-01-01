

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

def setup_profile(email, phone_number, country_code);
  print "==> Enter your First Name: "
  first_name = gets.chomp().to_s.capitalize
  print "==> Enter your Middle Name: "
  middle_name = gets.chomp().to_s.capitalize
  print "==> Enter your Last Name: "
  last_name = gets.chomp().to_s.capitalize


  loop do
    print '==> What is your gender [Male, Female, Custom]: '
    gender = gets.chomp.to_s.capitalize

    case gender
    when "Male"
      return gender = "Male"

    when "Female"
      return gender ="Female"

    when "Custom"
      return gender = "Custom"

    else
      puts "[ERROR] Please type a valid gender!"
    end
  end

  puts "Setting up profile, please wait....."
end
