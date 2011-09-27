When /^I create the following cards:$/ do |table|
  table.hashes.each do |hash|
    type "cd #{hash['name']}"
    hash.keys.each do |key|
      type "set #{key}"
      type hash[key]
    end
    type "exit"
  end
end