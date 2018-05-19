require_dependency '../../lib/google_api_wrapper'
require 'date'
class SessionsController < ApplicationController
  attr_reader :event_list
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

    calendar_list = service.list_calendar_lists

    # calendars_hash = {}
    # calendar_list.items.each do |calendar|
    #   calendars_hash[calendar.summary] = calendar.id
    # end
    return calendar_list.items.first
  end

  def events()
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
      @calendars_item = calendars
      event_list = service.list_events(@calendars_item.id)

      @event_list = event_list
      if @event_list.items && @event_list.items.length > 0
        @event_list.items.each do |event|
          puts "EVENT LOOKS LIKE: #{event.start}"
          addEventToDB(event)
        end
      end
      redirect_to root_path
  end

  def addEventToDB(event)
    newEvent = {
      title: event.summary,
      timeMin: event.start.date_time,
      timeMax: event.end.date_time,
      summary: event.description,
      location: event.location,
    }

    Event.create!(newEvent)
  end

  # def getEventByDate
  #   today = DateTime.today.
  #   todayEvents = Events.where()
  #
  # end
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
