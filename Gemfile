source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1.1"
# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"
# Use Puma as the app server
gem "puma", "~> 5.3"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 5.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Get notified of exceptions
gem 'exception_notification'

# Tagging
gem 'acts-as-taggable-on', git: 'git@github.com:mbleigh/acts-as-taggable-on.git'

# Use Slim templating engine
gem 'slim', '~> 3.0'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'simplecov', require: false

  # Allows stubbing HTTP requests and setting expectations on HTTP requests
  gem 'webmock', '~> 1.21'

  # One-liners that test common Rails functionality
  gem 'shoulda-matchers'
end

# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 2.0.2", group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  gem 'factory_bot_rails'
  gem "rspec-rails", "~> 3.9"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 4.1.0"
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  # Use Capistrano for deployment
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rvm', git: 'git@github.com:capistrano/rvm.git'

  gem 'guard-rspec', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
