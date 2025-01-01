require_relative 'db/users'
require_relative 'libs/auth'
require_relative 'libs/utlis'
require_relative 'account/profile'



def welcome()
  # Method to welcome Users
  puts ""
  puts "======================================"
  puts "Welcome to Wema Bank!".upcase()
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
    return loginUserView()

  when "3"
    return customerCare()

  when '4'
    return nearbyBanks()

  else
    puts "Oops, Looks like you entered an invalid option. Please try again"
    welcome()
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
  setup_profile(email, phone_number, country_code)


  # response = gets.chomp().to_i

end

# Method to authenticate Users
def loginUserView()
  puts '''
        ===================================
              LOGIN TO YOUR ACCOUNT
        ===================================
        Welcome Back, Dear Esteemed Customer
  '''

  print "Enter your Account Number: "
  acctNumber = gets.chomp().to_i
  print "Enter your 4-digt PIN: "
  acctPasscode = gets.chomp().to_i

  login(acctNumber, acctPasscode)
end




welcome
