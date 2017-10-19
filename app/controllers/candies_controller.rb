class CandyController < ApplicationController

# this route goes to candy home page with all candies
# all users can see this, should not have edit, delete buttons(others cant edit)
  get '/candies' do
    if logged_in? && current_user
      @user = current_user
      @candies = Candy.all
      erb :'/candies/home'
    else
      #flash message to login or signup
      redirect '/'
    end
  end

  get '/candies/new' do
    @candy = Candy.find_by(id: params[:id])
    if logged_in? && current_user
      @user = current_user
      erb :'/candies/new_candy'
    else
      #flash message to login or signup
      redirect '/'
    end
  end

  post '/candies' do
    @user = current_user
    if logged_in? && !params[:name].empty?
    @candy = Candy.create(name: params[:name])
    @user.candies << @candy
    redirect '/candies'
    end
  end

  get '/candies/:id' do
    @candy = Candy.find_by(id: params[:id])
    if logged_in?
      @user = current_user
      erb :'candies/show'
    else
      #flash message to login or signup
      redirect '/'
    end
  end





end
