require "pry"
class TweetsController < ApplicationController
    get '/tweets' do 
        if Helper.logged_in?(session)
        @current_user = Helper.current_user(session) if Helper.current_user(session) 
        @tweets = Tweet.all
        erb :"tweets/index"
        else
            redirect "/login"
        end
    end 

    get "/" do
       erb :"tweets/homepage" 
    end 

    get "/users/:id" do
       user= User.find(params[:id]) 
       if user 
        @tweets = user.tweets
        erb :"users/show"
       end
    end

    get "/tweets/new" do
        if Helper.logged_in?(session)
        erb :"tweets/new"
        else 
            redirect "/login"
        end
    end 

 

    post "/tweets" do
        if params[:content] != ""
            new_tweet = Tweet.create(content: params[:content])
            Helper.current_user(session).tweets << new_tweet
        else
            redirect "/tweets/new" 
        end
    end

    get "/tweets/:id/edit" do
       
        if Helper.logged_in?(session) 
            @tweet = Tweet.find(params[:id])
            
            erb :"tweets/edit"
        else
            redirect "/login"
        end
    end
    get "/tweets/:id" do
        if Helper.logged_in?(session) 
            @tweet= Tweet.find(params[:id]) 
            if @tweet  
                erb :"tweets/show"
            end
        else
            redirect "/login"
        end
    end

    patch "/tweets/:id" do
       
        @tweet = Tweet.find(params[:id])
        if params[:content] != "" 
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{params[:id]}/edit"
        end
    end

    delete "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        if Helper.current_user(session) == @tweet.user 
            @tweet.delete
            redirect "/tweets"
        else
            redirect "/tweets"
        end
    end


end
