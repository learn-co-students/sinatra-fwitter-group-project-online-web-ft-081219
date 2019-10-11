class UsersController < ApplicationController

    get "/signup" do
        if !Helper.logged_in?(session)
        @current_path = request.path_info
        erb :"users/signup_or_login"
        else 
            redirect "/tweets"
        end
    end

    get "/login" do
        if !Helper.logged_in?(session)
            @current_path = request.path_info
            erb :"users/signup_or_login"
        else 
                redirect "/tweets"
        end
    end 

    post "/login" do
        if params[:username] != "" && params[:password] != ""
            user = User.find_by(username: params[:username])
            if user && user.authenticate( params[:password])
                session[:user_id] = user.id 
                redirect "/tweets"
            else
                redirect "/login"
            end
        else
            redirect "/login"
        end
    end

    post "/signup" do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            new_user = User.create(params)
            session[:user_id] = new_user.id if new_user
            redirect "/tweets" if new_user
        else
            redirect "/signup"
        end
    end 


    # post "/logout" do
       
    #      session.clear 
    #      redirect "/login"
       
    # end

    get "/logout" do
        if Helper.logged_in?(session)
            session.clear 
            redirect "/login"
        else
            redirect "/login"
        end
      
    end
end
