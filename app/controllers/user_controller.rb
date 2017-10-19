require 'pry'
class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'/users/new_user'
    else
      @user = current_user
      redirect "/users/#{@user.slug}"
    end
  end

  post '/signup' do
    if params["username"] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.slug}"
    else
      #need to place flash/error message
      erb :'/users/new_user'
    end
  end

  get '/login' do
    if !logged_in?
    erb :'/users/login'
    else
      @user = current_user
      redirect "/users/#{@user.slug}"
    end
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.slug}"
      else
        #should have error message about info not being valid
        redirect '/login'
      end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
       erb :'/users/usersprofile'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
