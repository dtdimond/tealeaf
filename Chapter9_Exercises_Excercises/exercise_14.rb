contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}
keys = [:email, :address, :phone]

i = 0


contact_data.each do |value|
  contacts["Joe Smith"][keys[i]] = value
  i+=1
end

p contacts
