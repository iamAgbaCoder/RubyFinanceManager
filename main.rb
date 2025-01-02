require_relative 'db/users'
require_relative 'libs/signup'
require_relative 'libs/signin'



def welcome()
  # Method to welcome Users
  system("cls") | system("clear")
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
    system("cls") | system("clear") # clears terminal screen and loads the signup page
    return createAccountView()

  when "2"
    system("cls") | system("clear") # clears terminal screen and loads the signin page
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











welcome
