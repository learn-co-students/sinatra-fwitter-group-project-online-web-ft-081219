class TweetsController < ApplicationController

    get '/tweets' do
        redirect '/login' if !logged_in?
        current_user
        @tweets = Tweet.all
        erb :'/tweets/index'
    end

    get '/tweets/new' do
        redirect '/login' if !logged_in?
        current_user
        erb :'/tweets/new'
    end

    post '/tweets' do
        if params[:content].empty?
            redirect '/tweets/new'
        else
            current_user.tweets << Tweet.create(content:params[:content])
            redirect '/tweets'
        end
    end

    get '/tweets/:id' do
        redirect '/login' if !logged_in?
        @tweet = Tweet.find_by(id:params[:id])
        erb :'/tweets/show'
    end

    get '/tweets/:id/edit' do
        redirect '/login' if !logged_in?
        @tweet = Tweet.find_by(id:params[:id])
        erb :'/tweets/edit'
    end

    patch '/tweets/:id' do
        if params[:content].empty?
            redirect "/tweets/#{params[:id]}/edit"
        else
            Tweet.find_by(id:params[:id]).update(content:params[:content])
            redirect "/tweets/#{params[:id]}"
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by(id:params[:id])
        if current_user != @tweet.user
            redirect "/tweets/#{params[:id]}"
        else
            @tweet.delete
            redirect '/tweets'
        end
    end

    
end
