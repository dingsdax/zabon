# frozen_string_literal: true

require "bundler/gem_tasks"
require "bundler/audit/task"
require "rake/testtask"
require "rubocop/rake_task"

Bundler::Audit::Task.new
RuboCop::RakeTask.new

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.warning = false
  t.verbose = true
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Run code quality checks"
task code_quality: %i[bundle:audit rubocop]

task default: %i[code_quality test]
