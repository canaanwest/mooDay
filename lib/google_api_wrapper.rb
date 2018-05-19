# require 'httparty'
#
# class GoogleApiWrapper
#   BASE_URL = "https://www.googleapis.com/calendar/v3"
#   TOKEN = ENV['GOOGLE_TOKEN']
#
#   def self.getCalendarIDs(token = TOKEN)
#     url = BASE_URL + "/users/me/calendarList?pageToken=#{token}"
#     return HTTParty.get(url)
#   end
#
#   def calendars
#     client = Signet::OAuth2::Client.new(client_options)
#     client.update!(session[:authorization])
#
#     service = Google::Apis::CalendarV3::CalendarService.new
#     service.authorization = client
#
#     @calendar_list = service.list_calendar_lists
#     puts @calendar_list
#   end
#
# end
