Given /^table "([^']*)" a record$/ do |table, params|
  params = params.rows_hash
  table = "users".downcase.gsub(/s$/,"").capitalize.constantize
  assert_cucumber({
    assersion: table.new(params).save,
    error: "could not create row"
  })
end

Then /^table "([^']*)" has record$/ do |table, params|
  params = params.rows_hash
  table = table.downcase.gsub(/s$/,"").capitalize.constantize
  assert_cucumber({
    assersion: table.where(params).any?, 
    error: "could not find row"
  })
end

Then /^table "([^']*)" has records$/ do |table, params|
  params = params.rows_hash
  table = table.downcase.gsub(/s$/,"").capitalize.constantize
  assert_cucumber({
    assersion: table.where(params).any?,
    error: "could not find row"
  })
end