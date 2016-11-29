Given /^on page "([^']*)"$/ do |url|
  visit url
end

# ----------- search page ------------
Then /^text "([^']*)" on page$/ do |text|
  assert_cucumber({
    assersion: lambda{ page.has_content?(text) },
    error: "could not find text"
  })
end

Then /^no text "([^']*)" on page$/ do |text|
  assert_cucumber({
    assersion: lambda{ page.has_no_content?(text) },
    error: "could not find text"
  })
end

Then /^button "([^']*)" on page$/ do |text|
  assert_cucumber({
    assersion: lambda{ page.has_css?("button", text: text) },
    error: "could not find button"
  })
end

# ----------- page action -------------
Then /^fill input "([^']*)" with "([^']*)"$/ do |name, value|
  assert_cucumber({
    assersion: lambda{ page.fill_in(name, with: value) },
    error: "could not find input"
  })
end

Then /^click button "([^']*)" on page$/ do |name|
  assert_cucumber({
    assersion: lambda{ 
      page.click_button(name)
      sleep 3
    },
    error: "could not find button"
  })
end

Then /^click link "([^']*)" on page$/ do |name|
  assert_cucumber({
    assersion: lambda{ 
      page.click_link(name)
      sleep 3
    },
    error: "could not find link"
  })
end

