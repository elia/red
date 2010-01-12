%w[rubygems rake rake/clean fileutils newgem rubigen echoe].each { |f| require f }
require File.dirname(__FILE__) + '/lib/red'

$echoe = Echoe.new('red', Red::VERSION) do |p|
  p.author		 = 'Jesse Sielaff'
  p.email		 = 'jesse.sielaff@gmail.com'
  p.description          = 'Red writes like Ruby and runs like JavaScript.'
  p.changes              = '' #p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.name                 = 'red'
  p.rubyforge_name       = 'red-js'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

# task :default => [:spec, :features]

desc 'Install the gem locally without documentation'
task :local => [:install_gem_no_doc]
