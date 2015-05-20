require 'csv'

class LoadFiles 
  def initialize options = {}
    @options = options
  end
  
  def last_week_new
 	@last_week_new ||= load_csv @options[:last_week_new] #this method sets up a variable from the csv file, and keeps it so it doesn't load each time
  end

  def last_week_returning
 	@last_week_returning ||= load_csv @options[:last_week_returning] 
  end

  def week_before_last_new
 	@week_before_last_new ||= load_csv @options[:week_before_last_new] 
  end

  def week_before_last_returning
 	@week_before_last_returning ||= load_csv @options[:week_before_last_returning] 
  end

  def old_weeks_new
  	@old_weeks_new ||= load_directory @options[:old_weeks_new]
  end
  
  def week_before_last
    @week_before_last ||= (week_before_last_new + week_before_last_returning).uniq
  end

  def churn
    @churn ||= week_before_last - (week_before_last & last_week_returning)
  end


  private
 
  def load_csv path 
	  CSV.read(path).flat_map {|c| c[1]}.drop(1).compact.uniq  #this reads the csv file and pulls out the second column and gets rid of the headers
  end
  
  def load_directory path # loads the old_weeks_new directory
  	Dir.glob(path).flat_map {|f| load_csv f}.compact.uniq
  end
end




  #  def Resurrected
  # 	res = (old_weeks_new - week_before_last) & last_week_returning
  # 	res = res.count
  # end
