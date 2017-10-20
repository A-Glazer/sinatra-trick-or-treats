require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'happyhalloween'
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Flash
  end

  get "/" do
    erb :homepage
  end


  helpers do

    def current_user
       User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

  end

end
