require_dependency '../../lib/google_api_wrapper'

class SessionsController < ApplicationController
  def login_form
  end

  def home
  end

  def login
    auth_hash = request.env['omniauth.auth']
    puts auth_hash
    email = params[:email]
    puts "!!!!!!!username!!!!!"
    # unless username && username.length > 0
    #   render render_404
    # end
    if email and user = User.find_by(email: email)
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Successfully logged in as existing user #{user.username}"
    else
      puts "I'm making a new user!"
      user = User.new(email: email)
      user.save
      if user.save
        puts "I SAVED!"
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Successfully created new user #{user.email} with ID #{user.id}"
        @calendarList = GoogleApiWrapper.getCalendarIDs()
        puts @calendarList
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Could not log in"
        flash.now[:messages] = user.errors.messages
        render "login_form", status: :bad_request
        puts "Something went wrong!!!!"
        return
      end
    end
    redirect_to root_path
  end

  # def create
  #   @auth_hash = request.env['omniauth.auth']
  #   ap @auth_hash
  #
  #   @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])
  #
  #   if @user
  #     session[:user_id] = @user.id
  #     flash[:result_text] = "#{@user.name} has been logged in!"
  #
  #   else
  #     @user = User.new(uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['name'], email: @auth_hash['info']['email'], username: @auth_hash['info']['email'])
  #
  #     if @user.save
  #       session[:user_id] = @user.id
  #       flash[:result_text] = "#{@user.name} has been logged in!"
  #
  #     else
  #       flash[:result_text] = "Unable to save user!"
  #     end
  #   end
  #   redirect_to root_path
  # end


  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
     client = Signet::OAuth2::Client.new(client_options)
     client.code = params[:code]

     response = client.fetch_access_token!

     session[:authorization] = response

     redirect_to calendars_url
  end

  def calendars
  client = Signet::OAuth2::Client.new(client_options)
  client.update!(session[:authorization])

  service = Google::Apis::CalendarV3::CalendarService.new
  service.authorization = client

  @calendar_list = service.list_calendar_lists
  puts @calendar_list
  puts "^^^^^^^^^^^^ right dere"
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
