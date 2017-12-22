source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails',                        '~> 5.1.4'
gem 'pg',                           '~> 0.21.0'
gem 'bcrypt',                       '~> 3.1.7'
gem 'simplec',                      '~> 0.8.1'
gem 'presents',                     '~> 1.0.3'
gem 'dragonfly',                    '~> 1.1.2'
gem 'dragonfly-s3_data_store',      '~> 1.3.0'
gem 'jquery-rails',                 '~> 4.3.1'
gem 'bootstrap',                    '~> 4.0.0.beta'
#gem 'bootstrap-sass', '~> 3.3.7'

gem 'puma',           '~> 3.10.0'

gem 'turbolinks',     '~> 5'
gem 'sass-rails',     '~> 5.0'
gem 'uglifier',       '>= 1.3.0'

#gem 'jbuilder',       '~> 2.5'
#gem 'coffee-rails',   '~> 4.2'

gem 'kaminari',                 '~> 1.0.1' #paging

group :development, :test do
  gem 'capybara',     '~> 2.13'
  gem 'selenium-webdriver'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :staging, :production do
  gem 'rack-cache',                     '~> 1.7.1',
    :require => 'rack/cache'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
