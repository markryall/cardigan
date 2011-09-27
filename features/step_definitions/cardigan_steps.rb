When /^I create the following cards:$/ do |table|
  table.hashes.each do |hash|
    type "touch #{hash['name']}"
    type "cd #{hash['name']}"
    hash.keys.each do |key|
      next if key == 'name'
      type "set #{key}"
      type hash[key]
    end
    type "exit"
  end
end