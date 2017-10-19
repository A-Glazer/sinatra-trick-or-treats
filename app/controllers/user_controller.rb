require 'pry'
class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'/users/new_user'
    else
      redirect '/candies' #need to figure out where this will redirect
    end
  end

  post '/signup' do
    if params["username"] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    redirect '/candies' #need to figure out where this will redirect
    else
      #need to place flash/error message
      erb :'/users/new_user'
    end
  end

  get '/login' do
    if !logged_in?
    erb :'/users/login'
    else
      redirect '/candies' #need to figure out where this should redirect
    end
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/candies' #need to figure out where this should redirect
      else
        #should have error message about info not being valid
        redirect '/login'
      end
  end

  get '/users/:id' do
    @candies = Candy.find_by(name: params[:name])
    @user = User.find_by(username: params[:username])
    if logged_in? && current_user
       @user = current_user
       erb :'/users/usersprofile'
     else
       redirect '/'
     end
    end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

end
