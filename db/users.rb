require 'json'

$db = nil # Instaniate dummy DB

File.open("db/db.json", "r") do |file|
 $db = JSON.parse(file.read)
 return $db
 # puts $db
end
