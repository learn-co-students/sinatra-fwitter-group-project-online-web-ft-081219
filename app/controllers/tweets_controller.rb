class TweetsController < ApplicationController
  get '/tweets' do 
    #binding.pry 
    if logged_in?
      #binding.pry
      erb :'users/tweets'
    else 
      redirect '/login'
      #binding.pry
    end
  end

  get '/tweets/new' do 
    #binding.pry 
    #@user = User.find(session[:user_id])
    erb :'tweets/new'
  end 

  post '/tweets/:id' do 
    redirect '/tweets'
  end


  get '/tweets/:id' do 
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do 
    erb :'/tweets/edit_tweet'
  end
end
