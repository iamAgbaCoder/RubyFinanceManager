require 'json'

$db = nil # Instaniate dummy DB

File.open("db/db.json", "r") do |file|
  if file
    $db = JSON.parse(file.read)
    return $db
  end

 # puts $db
end
