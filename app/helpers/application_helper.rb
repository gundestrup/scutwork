# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

 def dkk(number)   
   (number_to_currency(number*0.01))
 end

  def dkktime(time)
    time.strftime('%Y-%B-%d %H:%M')
  end

  def dkktimeweek(time)
    time.strftime('%Y #%W %B-%d %H:%M')
  end

  def dkktime_short(time)
    time.strftime("#%W %a %d %H:%M")
  end

  def dkkhour(time)
    time.strftime('%H:%M')
  end

  def hours(hours)
    number_with_precision(hours*0.01, :precision => 2)
  end

  def seconds_to_time(seconds)
    Time.at(seconds).gmtime.strftime('%R')    
  end

end
