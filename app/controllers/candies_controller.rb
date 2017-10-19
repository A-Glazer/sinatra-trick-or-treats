class CandyController < ApplicationController

  get '/candies' do
    if logged_in?
      @user = current_user
      @candies = Candy.all
      erb :'/candies/home'
    else
      redirect '/login'
    end
  end

  get '/candies/new' do
    @candy = Candy.find_by(id: params[:id])
    if logged_in?
      @user = current_user
      erb :'/candies/new_candy'
    else
      redirect '/login'
    end
  end

  post '/candies' do
    @user = current_user
    @candy = Candy.create(name: params[:name])
    @user.candies << @candy
    redirect '/candies/:id'
  end

  get '/candies/:id' do
    @candy = Candy.find_by(id: params[:id])
    if logged_in?
      @user = current_user
      erb :'candies/show'
    else
      redirect '/login'
    end
  end





end
