require "bundler/gem_tasks"
require 'dotenv/tasks'

task :console => :dotenv do
  require 'irb'
  require 'irb/completion'
  require 'yahoo_fantasy_sports_client'
  ARGV.clear
  IRB.start
end
