When /^I create the following cards:$/ do |table|
  table.raw.each do |row|
    type "touch #{row.first}"
  end
end