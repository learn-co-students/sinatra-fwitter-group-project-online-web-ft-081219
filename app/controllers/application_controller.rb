require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    #binding.pry
      erb :index
  end

  get '/logout' do 
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/login' do 
    #binding.pry
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  get '/signup' do 
    #binding.pry
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/login' do 
    #binding.pry
    #if logged_in?
      #redirect '/tweets'
    #else
      @user = User.find_by(username: params[:username])
      if @user != nil && @user.authenticate(params[:password]) 
        session[:user_id]  = @user.id  
        redirect '/tweets'
      else
        redirect '/login'
      end
    #end
  end

  post '/signup' do 
    #binding.pry
    #if !logged_in?
      if params["username"] == "" || params["email"] == "" || params["password"] == ""
        redirect to '/signup'
      else 
        @user = User.create(username: params["username"], email: params["email"], password: params["password"])
        @user.save 
        session[:user_id] = @user.id   
        
        redirect to "/tweets"
      end
    #else 
      #redirect '/login'
    #end   
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
