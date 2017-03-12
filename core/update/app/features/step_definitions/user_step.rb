Given /^a user$/ do |params|
  params = params.rows_hash
  unless User.find_by({username: params[:username]})
    assert_cucumber({
      assersion: lambda{ User.new(params).save }, 
      error: "could not create user"
    })
  end
end

Then /^users has username "([^']*)"$/ do |username|
  assert_cucumber({
    assersion: lambda{ User.exists?({username: username}) }, 
    error: "could not find user"
  })
end