require_dependency '../../lib/google_api_wrapper'
require 'date'
class SessionsController < ApplicationController
  attr_reader :event_list, :added
  @color= ""

  def root
    @calendars_item = calendars
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

  def login
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
     client = Signet::OAuth2::Client.new(client_options)
     client.code = params[:code]

     response = client.fetch_access_token!

     session[:authorization] = response

     redirect_to root_path
  end

  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    calendar_list = service.list_events('primary')
    return calendar_list.items.first
  end

  def fetchEvents()
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
      @calendars_item = calendars
      event_list = service.list_events('primary')
      return event_list
  end

  def events()
    if Event.first == nil
      @event_list = fetchEvents()
      if !@added
        if @event_list.items && @event_list.items.length > 0
          @event_list.items.each do |event|
            puts "EVENT LOOKS LIKE: #{event.start}"
            addEventToDB(event)
          end
        end
        @added = true
      end
    end
      #gets the collection of events for today.
    @eventsToday = eventsToday
    if @eventsToday
      @color = decideColor
    end
    @nextEvent = getClosestEvent
      # redirect_to root_path
  end

  def addEventToDB(event)
      newEvent = {
        title: event.summary,
        time_min: event.start.date_time,
        time_max: event.end.date_time,
        summary: event.description,
        location: event.location,
      }
      Event.create!(newEvent)
      puts "NEW EVENT: #{newEvent}"
  end

  def eventsToday
    today = DateTime.now
    puts "TIME TODAY: #{today}"
    @eventsToday = Event.where('time_min > ?', today)
    return @eventsToday
  end

  def decideColor
    moods = {
      "green" => ["1:1", "one-on-one", "reflection", "consensus", "build"],
      "blue" => ["heads", "down", "focus", "edit", "proof", "review", "independent"],
      "red" => ["debate", "defen", "presentation", "persua"],
      "yellow" => ["inspire", "brainstorm", "teach", "mentor", "social", "Team Presentations"]
    }
    event = getClosestEvent
    containsWords = []
    puts "EVENT: #{event}"
    containsWords.push(event.title)
    if event.summary != nil
      containsWords.push(event.summary)
    end

    moods.each do |kee, list|
      list.each do |taskword|
        if containsWords.include?(taskword)
          puts "taskword: #{taskword}"
          @color= kee
          puts "#{@color}"
          return @color
        end
      end
    end
    puts "GREEN!!!!!"
    return @color= "green"
  end

  def getClosestEvent()
    todaysEvents = eventsToday
    curTime = Time.now().to_s.split(" ")[1]

    i = 0
    while i < todaysEvents.length-1
      cur_event_time = todaysEvents[i].time_min.split("T")[1]
      next_event_time = todaysEvents[i+1].time_min.split("T")[1]

      if next_event_time > curTime && curTime > cur_event_time
        return todaysEvents[i]
      end
      i+=1
    end
  
    return todaysEvents.last
  end

  private
  def client_options
    {
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end



end
