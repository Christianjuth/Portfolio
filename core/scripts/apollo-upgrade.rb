require "github_api";
require 'tty'
require "json"
prompt = TTY::Prompt.new
apollo = JSON.parse(File.read("./apollo.json"))

class String
  def green
    "\033[0;32m#{self}\033[0m" 
  end
end

github = Github.new do |config|
  config.adapter     = :net_http
end

update_prompt = []
updates = {}

github.repos.releases.all('Christianjuth', 'apollo-8').each do |release, i|
  core = apollo["apollo_core"]
  if release.tag_name.gsub(/[a-z]*/, "") > core["version"].gsub(/[a-z]*/, "")
    update_prompt.push(release.tag_name)
    updates[release.tag_name] = release.zipball_url
  end
end

if update_prompt.length > 0
  update_version = prompt.enum_select("Select version...", update_prompt)
  update_url = updates[update_version]

  system("mkdir core/update >/dev/null")
  system("curl -L #{update_url} -o core/update/app.zip")
  system("unzip core/update/app -d core/update/extracted >/dev/null")
  system("rm core/update/app.zip")
  system("mkdir core/update/app >/dev/null")
  system("mv core/update/extracted/*/* core/update/app")
  system("rm -rf core/update/extracted")
  system("cp -Rf core/update/app/core/* core/")
  system("rm -rf core/update/app")
  
  apollo["apollo_core"]["version"] = update_version 
  File.open("./apollo.json", 'w') { |file| file.write(JSON.pretty_generate(apollo)) }
  puts "\nUpdated Apollo to #{update_version}".green
else
  puts "Apollo already up to date".green
end

