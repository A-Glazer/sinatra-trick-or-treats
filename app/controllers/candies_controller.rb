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
    if logged_in?
      erb :'/candies/new_candy'
    else
      redirect '/login'
    end
  end

  post '/candies' do
    "Hello World"
  end



end
