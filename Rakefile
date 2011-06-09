# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "ebayer"
  gem.homepage = "http://github.com/kranthicu/ebayer"
  gem.license = "MIT"
  gem.summary = %Q{Ebay API now made easy for rubyists and rails}
  gem.description = %Q{This gem intended to use Ebay API withint ruby/rails applications}
  gem.email = "kranthicu@gmail.com"
  gem.authors = ["kranthicu"]
  gem.files = Dir["{lib}/**/*"]
  gem.add_development_dependency "httparty", ">= 0"
  gem.add_development_dependency "json", ">= 0"
  gem.add_development_dependency "hashie", ">= 0"
  gem.add_development_dependency "rspec"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ebayer #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
