require 'rake/testtask'

desc 'Run Baseball unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'domain'
  t.libs << 'app'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = false
end