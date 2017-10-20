class CandyController < ApplicationController

  get '/candies' do
    if logged_in? && current_user
      @user = current_user
      session[:user_id] = @user.id
      @candies = Candy.all
      erb :'/candies/home'
    else
      redirect '/'
    end
  end

  get '/candies/new' do
    @candy = Candy.find_by(id: params[:id])
    if logged_in? && current_user
      @user = current_user
      session[:user_id] = @user.id
      erb :'/candies/new_candy'
    else
      flash[:notice] = "You're not logged in"
      redirect '/'
    end
  end

  post '/candies' do
    @user = current_user
    if logged_in? && !params[:name].empty?
    @candy = Candy.create(name: params[:name])
    @user.candies << @candy
    redirect '/candies'
    else
      redirect '/candies/new'
    end
  end

  get '/candies/:id' do
    if logged_in?
      @user = current_user
      @candy = Candy.find_by(id: params[:id])
      erb :'candies/show'
    else
      flash[:message] = "You're not logged in"
      redirect '/'
    end
  end

  get '/candies/:id/edit' do
    if logged_in?
      @candy = Candy.find_by(id: params[:id])
      erb :'candies/edit'
    else
      flash[:notice] = "You're not logged in"
      redirect '/'
    end
  end

  patch '/candies/:id' do
    if logged_in? && !params[:name].empty?
      @candy = Candy.find_by(id: params[:id])
      @candy.name = (params[:name])
      @candy.save
      redirect "/candies/#{@candy.id}"
    else
      flash[:notice] = "Invalid Fields"
      redirect "/candies/#{params[:id]}/edit"
    end
  end

  delete '/candies/:id/edit' do
    @candy = Candy.find_by(id: params[:id])
    @user = current_user
    if logged_in?
      @candy.delete
      redirect '/candies'
    else
      redirect "/candies/#{@candy.id}"
    end
  end

end
