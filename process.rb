#!/usr/bin/env ruby
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

require 'trollop'
require 'ap'

opts = Trollop::options do
  banner = ":Usage =>ruby process.rb [options]" 
  opt :last_week_new,				"Last week new users, csv data", :type => :string, default: "last_week_new/last_week_t.csv"
  opt :last_week_returning,			"Last week returning users, csv data", :type => :string, default: "last_week_returning/last_week_f.csv"
  opt :week_before_last_new,		"Week before last week, new users, csv data", :type => :string, default: "week_before_last_new/week_before_last_t.csv"
  opt :week_before_last_returning,	"Week before last week, returning users, csv data", :type => :string, default: "week_before_last_returning/week_before_last_f.csv"  
  opt :old_weeks_new,				"Old weeks of data, prior to week before last week, new users csv data", :type => :string, default: "old_weeks_new/*.csv"
  # opt :old_weeks_returning,			"Old weeks of data, prior to week before last week, returning users csv data", :type => :string, default: "old_weeks_returning"	
end

trap("INT") { exit }

files = LoadFiles.new(opts)
ap files.last_week_new.count
ap files.last_week_returning.count
ap files.week_before_last_new.count
ap files.week_before_last_returning.count
ap files.old_weeks_new.count
