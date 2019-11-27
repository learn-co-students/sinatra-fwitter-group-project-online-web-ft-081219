class TweetsController < ApplicationController
  get '/tweets' do 
    #binding.pry
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else 
      redirect '/login'
    end
  end

  get '/tweets/new' do 
    
    if logged_in?
      erb :'tweets/new'
    else 
      redirect '/login'
    end
  end 

  post '/tweets' do 
    #binding.pry
    if logged_in? 
      tweet = current_user.tweets.build(content: params[:content])
      if params[:content] == ""    
        redirect '/tweets/new'
      else
        tweet.save
        redirect "/tweets"
      end
    else 
      redirect '/login'
    end
  end

  get '/tweets/:id' do 
    #binding.pry
    if logged_in?
      
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else 
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit_tweet'
    else 
      redirect '/login'
    end
  end

  patch '/tweets/:id' do 
    #
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if params[:content] == ""
        redirect "/tweets/#{tweet.id}/edit"
      else
        tweet.update(content: params[:content])
        tweet.save
        redirect "/tweets/#{tweet.id}"
      end
    else 
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do 
    #binding.pry
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if tweet.user_id == current_user.id
        tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end


  helpers do 
    def logged_in?
      #binding.pry
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
