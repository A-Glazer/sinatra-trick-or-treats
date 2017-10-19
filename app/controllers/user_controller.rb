class UserController < ApplicationController

  get '/signup' do
    erb :'/users/new_user'
  end

end
