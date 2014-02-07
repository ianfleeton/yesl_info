source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.beta1'

# Use Slim templating engine
gem 'slim', '~> 2.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Calendar
gem 'simple_calendar'

# Markdown
gem 'redcarpet'

group :development do
  gem 'thin'
end

group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'libv8'
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'mysql2'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc',          group: :doc, require: false

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

group :development do
  # Use Capistrano for deployment
  gem 'capistrano'
  gem 'rvm-capistrano'

  gem 'guard-rspec', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/jonleighton/spring
  gem 'spring'
  gem 'spring-commands-rspec'
end

# Use debugger
# gem 'debugger', group: [:development, :test]
