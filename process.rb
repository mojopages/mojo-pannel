#!/usr/bin/env ruby
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

require 'trollop'
require 'ap'

opts = Trollop::options do
  banner = ":Usage =>ruby process.rb [options]" 
  opt :last_week_new,				"Last week new users, csv data", :type => :string
  opt :last_week_returning,			"Last week returning users, csv data", :type => :string
  opt :week_before_last_new,		"Week before last week, new users, csv data", :type => :string
  opt :week_before_last_returning,	"Week before last week, returning users, csv data", :type => :string  
  opt :old_weeks,					"Old weeks of data, prior to week before last, of csv data", :type => :string, default: "old_weeks"
end

trap("INT") { exit }

ap opts