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

  get '/candies/:id/edit' do
    @candy = Candy.find_by(id: params[:id])
    if logged_in? && @candy.user == current_user
      erb :'candies/edit'
    else
      redirect '/'
    end
  end

  patch '/candies/:id' do
    @candy = Candy.find_by(id: params[:id])
    if logged_in? && @candy.user == current_user && !params[:name].empty?
      @user = current_user
      @candy.update(name: params[:name])
      @candy.save
      redirect "/candies/#{@candy.id}"
    else
      redirect "/candies/#{@candy.id}/edit"
    end
  end

  delete '/candies/:id/delete' do
    @candy = Candy.find_by(id: params[:id])
    @user = current_user
    if logged_in? && @candy.user == current_user
      @candy.delete
      redirect '/candies'
    else
      redirect "/candies/#{@candy.id}"
    end
  end





end
