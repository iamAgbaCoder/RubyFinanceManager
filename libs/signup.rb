require_relative "utils"
require_relative "auth"

# Method to create user account
def createAccountView();

  puts """
      ===========================
        CREATE A WEMA ACCOUNT
      ===========================
      Please carefully enter valid response.
          Let's get you started!
  """

  email = get_email()
  phone_number, country_code = verify_phonenumber()
  setup_profile(email, phone_number, country_code)

end
