require 'httparty'

class GoogleApiWrapper
  BASE_URL = "https://www.googleapis.com/calendar/v3"
  TOKEN = ENV['GOOGLE_TOKEN']

  def self.getCalendarIDs(token = TOKEN)
    url = BASE_URL + "/users/me/calendarList?pageToken=#{token}"
    return HTTParty.get(url)
  end

end
