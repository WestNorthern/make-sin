
# assumes that before you run the script you have cd'd into the folder in which 
# you want the Sinatra Project to be made
# ruby ~/sin-script.rb

puts "User! Input the name of your project!"

dir_name = gets.chomp.downcase

`mkdir #{dir_name}`

puts "Making your sinatra project..."

`touch #{dir_name}/main.rb`

puts "Creating models file"

`touch #{dir_name}/models.rb`

puts "Making your Gemfile..."

`touch #{dir_name}/Gemfile`

puts "Making your Rakefile..."

`touch #{dir_name}/Rakefile`

puts "Making your views folder..."

`mkdir #{dir_name}/views`
`touch #{dir_name}/views/home.erb`
`touch #{dir_name}/views/layout.erb`

puts "Making your public file..."

`mkdir #{dir_name}/public`
`mkdir #{dir_name}/public/css`
`touch #{dir_name}/public/css/main.css`

puts "Set up home route in main.rb"

File.open("#{dir_name}/main.rb", "r+") do |file|
	file.write(%(require 'sinatra'
    require 'sinatra/activerecord'
    require './models'

    set :database, "sqlite3:main.sqlite3"
    
		get '/' do
			erb :home
		end
		
	))
end

puts "Set up home route in main.rb"

File.open("#{dir_name}/models.rb", "r+") do |file|
  file.write(%(
    class User < ActiveRecord::Base
    end
  ))
end


puts "Setting up Gemfile..."

File.open("#{dir_name}/Gemfile", "r+") do |file|
	file.write(%(source 'https://rubygems.org' #Where to get the gems
ruby '2.4.2' # ruby version

gem 'sinatra', '~> 2.0'

gem 'activerecord'
gem 'sinatra-activerecord'
gem 'sqlite3'
gem 'rake'

	))
end

puts "Setting up rake file"

File.open("#{dir_name}/Rakefile", "r+") do |file|
  file.write(%(require 'sinatra/activerecord/rake'

    require './main'
    
  ))
end


puts "Writing BS boilerplate for layout.erb..."

File.open("#{dir_name}/views/layout.erb", "r+") do |file|
	file.write(%(<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
  </head>
  <body>

    <%= yield %>

    <!-- jQuery first, then Tether, then Bootstrap JS. -->
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
  </body>
</html>
	))
end

puts "Quick hello world in home.erb..."

File.open("#{dir_name}/views/home.erb", "r+") do |file|
	file.write(%(
		<h1>Hello world!</h1>
	))
end


puts "Bundling and starting server..."
Dir.chdir("#{dir_name}")
`bundle && ruby main.rb`

