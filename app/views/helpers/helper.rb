class Helper
    def self.current_user(session) 
        @user = User.find(session[:user_id]) if self.logged_in?(session)
    end 

    def self.logged_in?(session) 
        true if session[:user_id]
    end
end