# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :integration do
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = 'spec/widgets/*_spec.rb'
  end
end

task :unit do
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = 'spec/unit/**/*_spec.rb'
  end
end
