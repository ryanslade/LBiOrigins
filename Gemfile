source 'http://rubygems.org'

gem 'rails', '3.0.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# Bundle the extra gems:
gem 'httparty'
gem "jquery-rails"

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
   #gem 'webrat'
   gem 'ruby-debug19', :require => 'ruby-debug'
end

group :production do
  gem "thin" # Thin required to work on CloudFoundry
end