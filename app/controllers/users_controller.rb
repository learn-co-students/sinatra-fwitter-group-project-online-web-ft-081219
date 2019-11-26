class UsersController < ApplicationController

  get '/signup' do 
    #binding.pry
    if logged_in?
      redirect '/tweets'
    else 
      erb :'users/create_user'
    end
  end

  post '/signup' do 
    #binding.pry
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
  
    if @user.username != "" && @user.email != "" && @user.password
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      redirect to '/signup'
    end
    redirect to "/"
  end

  get '/login' do 
    #binding.pry
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do 
    #binding.pry
    @user = (User.find_by(username: params[:username]))

    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else 
      redirect '/login'
    end
  end

  get '/logout' do 
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
