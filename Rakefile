require "bundler/gem_tasks"
require 'dotenv/tasks'

task :console => :dotenv do
  require 'irb'
  require 'irb/completion'
  require 'yahoo_fantasy_sports_active_resource'
  ARGV.clear
  IRB.start
end
