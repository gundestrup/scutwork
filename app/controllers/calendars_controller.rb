class CalendarsController < ApplicationController
  before_filter :getting_access
  layout false
  require 'icalendar'
  require 'date'
  include Icalendar
  #require 'spreadsheet/excel'
  require 'spreadsheet'
  include Spreadsheet  

  def index  #creates ICAL feed, working with MAC    

      # Generated url
      # http://localhost:3000/calendars/index?user_id=1&access_code=xxx
      #type = params[:type]

        #Generates the feed
        cal = Calendar.new
        cal.product_id = "-//scutwork.dk//iCal 1.0//EN"
        cal.custom_property("X-WR-CALNAME;VALUE=TEXT", 'Scutwork')
        cal.custom_property("X-WR-TIMEZONE;VALUE=TEXT", "Europe/Paris")


        events(cal)
        timezones(cal)
    
  end


  def google

    # Generated url
    # http://localhost:3000/calendars/google?user_id=1&access_code=xxx
    #type = params[:type]


      cal = Calendar.new

      events(cal)
      timezones(cal)

  end

  def excel

      # Creating save path
      @path ="#{RAILS_ROOT}/excel/#{@user.id.to_s+@user.name}"
      # Setting format to UTF8
      Spreadsheet.client_encoding = 'UTF-8'
      # createing new excel workbook
      book = Spreadsheet::Workbook.new
      # creating a sheet in the workbook
      sheet1 = book.create_worksheet
      #sheet2 = book.create_worksheet :name => 'My Second Worksheet'
      #Provising a name for the sheet
      sheet1.name = 'Scutwork'
      #Setting colums headers
      sheet1.row(0).concat %w{Hospital Date Hours Pay}

      #Line 2(1)
      #sheet1[1,0] = 'Japan'
      #row = sheet1.row(1)
      #row.push 'Creator of Ruby'
      #row.unshift 'Yukihiro Matsumoto'
      #line 3(2)
      #sheet1.row(2).replace [ 'Daniel J. Berger', 'U.S.A.',
      #                        'Author of original code for Spreadsheet::Excel' ]
      #Line 4(2)
      #sheet1.row(3).push 'Charles Lowe', 'Author of the ruby-ole Library'
      #sheet1.row(3).insert 1, 'Unknown'
      #Line 5(4)
      #sheet1.update_row 4, 'Hannes Wyss', 'Switzerland', 'Author'
      number = 1
      for shift in @user.shifts
        sheet1.row(number).insert 0, shift.place.name, shift.start, Shift.duration(shift.id), Shift.paytotal(shift.id)/100
        number = number + 1
      end
      #################
      # Formatting
      #################
      sheet1.row(0).height = 18

      format = Spreadsheet::Format.new :color => :blue,
                                       :weight => :bold,
                                       :size => 18

      sheet1.row(0).default_format = format

      bold = Spreadsheet::Format.new :weight => :bold
      4.times do |x|
        sheet1.row(x + 1).set_format(0, bold)
      end

      ##################
      # Sending to browser
      ##################
      book.write(@path+'.xls')
      send_file (@path+'.xls'), :type => 'application/vnd.ms-excel', :disposition => 'inline'

  end

  protected

  def events(cal)
    @user.shifts.each do |shift|
        event = Event.new
        event.dtstart = shift.start.strftime("%Y%m%dT%H%M%S")
        event.dtend = shift.end.strftime("%Y%m%dT%H%M%S")
        event.summary = shift.place.name
        event.location = shift.place.name
        event.uid = shift.uuid        
        cal.add_event(event)
      end
  end

  def timezones(cal)
    #utf8
    cal.prodid = "-//scutwork.dk//iCal 1.0//EN"
    $KCODE = 'u'

    ####################
    # Timezone         #
    ####################

    timezone = Icalendar::Timezone.new
    daylight = Icalendar::Daylight.new
    standard = Icalendar::Standard.new

    timezone.timezone_id = "Europe/Paris"

    daylight.timezone_offset_from = "+0100"
    daylight.timezone_offset_to = "+0200"
    daylight.timezone_name = "CEST"
    daylight.dtstart = "19700308T020000"
    daylight.recurrence_rules = ["FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU"]


    standard.timezone_offset_from = "+0200"
    standard.timezone_offset_to = "+0100"
    standard.timezone_name = "CEST"
    standard.dtstart = "19701101T020000"
    standard.recurrence_rules = ["FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU"]


    timezone.add(daylight)
    timezone.add(standard)
    cal.add(timezone)


    ####################
    # Timezone -END    #
    ####################

    cal.publish
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
    render :text => cal.to_ical.gsub("\\;", ";")
  end  

  def getting_access
     if params[:access_code].present? && params[:feed_id].present?
       access_code = params[:access_code]
       feed_id = params[:feed_id]
       @feed = Feed.find(:first, :conditions => ['id = ? AND access_code = ?', feed_id, access_code])
       if @feed.active
        @user = @feed.user
       else
         redirect_to('/')
         flash[:error] = t('calendar.incorrect_login')
         return
       end
    end

    if params[:access_code].present? && params[:user_id].present?
      access_code = params[:access_code]
      user_id = params[:user_id]
      @user = User.find(:first, :conditions => ['id = ? AND access_code = ?', user_id, access_code])
    end

    if @user.nil?
      redirect_to('/')
      flash[:error] = t('calendar.incorrect_login')
      return
    end

  end


end
