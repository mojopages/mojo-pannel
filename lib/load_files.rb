require 'csv'

class LoadFiles 
  def initialize options = {}
    @options = options
  end
  
  def last_week_new
 	@last_week_new ||= load_file @options[:last_week_new] #this method sets up a variable from the csv file, and keeps it so it doesn't load each time
  end

  def last_week_returning
 	@last_week_returning ||= load_file @options[:last_week_returning] 
  end

  def week_before_last_new
 	@week_before_last_new ||= load_file @options[:week_before_last_new] 
  end

  def week_before_last_returning
 	@week_before_last_returning ||= load_file @options[:week_before_last_returning] 
  end

  def old_weeks_new
  	@old_weeks_new ||= load_files @options[:old_weeks_new]
  end
  
  def week_before_last
    @week_before_last ||= (week_before_last_new + week_before_last_returning).uniq
  end

  def churn
    @churn ||= week_before_last - (week_before_last & last_week_returning)
  end

  def rez
    @rez ||= (old_weeks_new - week_before_last) & last_week_returning
  end

  def return_first_week
    @return_first_week ||= (last_week_new & last_week_returning).compact.uniq
  end

  def total_weekly_users
    @total_weekly_users ||= last_week_new + (last_week_returning - return_first_week)
  end

  
  private
 
  def load_csv path
    csv = CSV.read(path).drop(1)
    initial_hash = csv.map {|c| c[1] }.compact.uniq.map {|c| { c => [] } }.reduce({}, :merge)
    csv.each {|c| initial_hash[c[1]] << c[2] }
    initial_hash.delete_if {|k,v| v.count > 3 }.keys
  end
  
  def load_file path # loads csv file
    load_csv Dir.glob(path).first
  end
  
  def load_files path # loads the old_weeks_new directory, puts them all in a single csv file
  	Dir.glob(path).flat_map {|f| load_csv f}.drop(1).compact.uniq
  end
end

