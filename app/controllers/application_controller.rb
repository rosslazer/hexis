class ApplicationController < ActionController::Base
  protect_from_forgery


    def after_sign_up_path_for(resource)
    "/skills/new" # <- Path you want to redirect the user to.
  	end

end
