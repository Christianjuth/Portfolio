Given /^table "([^']*)" a record$/ do |table, params|
  params = params.rows_hash
  table = table.classify.constantize
  record = table.new(params)
  assert_cucumber({
    assersion: lambda{ record.save },
    error: error_for(record)
  })
end

Then /^table "([^']*)" has record$/ do |table, params|
  params = params.rows_hash
  table = table.downcase.gsub(/s$/,"").capitalize.constantize
  assert_cucumber({
    assersion: lambda{ table.where(params).any? }, 
    error: "could not find row"
  })
end

Then /^table "([^']*)" has records$/ do |table, params|
  params = params.rows_hash
  table = table.downcase.gsub(/s$/,"").capitalize.constantize
  assert_cucumber({
    assersion: lambda{ table.where(params).any? },
    error: "could not find row"
  })
end


# ----- Helpers -----
def error_for(object)
  if object.errors.first
    return "#{object.errors.first[0].capitalize} #{object.errors.first[1]}"
  else
    return ""
  end
end