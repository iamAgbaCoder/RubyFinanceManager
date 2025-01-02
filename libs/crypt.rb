require "securerandom"
require_relative '../db/users'

def acctNumber_exists?(acctNumber)
  $db['Users'].each do |id, user|
    return true if user['acctNumber'] == acctNumber
  end
  false
end

def generate_account_number()
  loop do
    # Combine a timestamp with a random 4-digit number
    timestamp = Time.now.to_i.to_s
    random_suffix = rand(1000..9999).to_s
    acctNumber = "#{timestamp[-6..]}#{random_suffix}" # Ensure it's within 10 digits

    if acctNumber_exists?(acctNumber)
      puts "Regenerating Unique Account Number..."
      sleep(3)
    else
      return acctNumber
      break
    end
  end

end


def validatePIN(pin, confirm_pin);
  if pin == confirm_pin
    return true
  else
    return false
  end
end

# # Example usage:
# new_account_number = generate_account_number
# puts "Generated Account Number: #{new_account_number}"
