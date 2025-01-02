require_relative "auth"
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
