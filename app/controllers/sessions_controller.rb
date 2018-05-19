require_dependency '../../lib/google_api_wrapper'
require 'date'
class SessionsController < ApplicationController
  def root
    @calendars_hash = calendars
    # @events = events
    # @calendar_id = params[:calendar_id]
    #
    # puts "calendarID: ~~~~~~~#{@calendar_id}~~~~~~~~"
    #
    # if @calendar_id
    #   @event_list = events(@calendar_id)
    #   puts "eventLIst: #{@event_list}"
    # end
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

    calendars_hash = {}
    calendar_list.items.each do |calendar|
      calendars_hash[calendar.summary] = calendar.id
    end
    return calendars_hash
  end

  def events()
    puts "calendarID: ~~~~~~~#{@calendar_id}~~~~~~~~"
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    eventParams = {
      calendarId: params[:calendar_id],
      timeMin: Date.
      timeMax: Date.

    }
    # if !calendar_id.nil?
      @event_list = service.list_events(eventParams)
    # else
    #   @event_list = calendars
    # end

    redirect_to root_path
    return @event_list
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
