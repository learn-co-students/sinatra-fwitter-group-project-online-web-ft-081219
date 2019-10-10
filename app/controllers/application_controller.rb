require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "hand"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    user = User.create(:username=>params[:username], :email=>params[:email], :password=>params[:password])
    if !!user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect '/signup'
    end   
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    user = User.find_by(username:params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear if logged_in?
    redirect '/login'
  end


  helpers do
    def current_user
      @user||=User.find_by(id:session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def slug
      self.name.gsub(" ","-").downcase
    end

  end

end
