class UsersController < ApplicationController
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :show
    end

    helpers do
        def current_user
          @user||=User.find_by(id:session[:user_id])
        end
    
        def logged_in?
          !!current_user
        end
    
    
      end

end
