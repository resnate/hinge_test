module Api
    module V1
		class Api::V1::ApiController < ActionController::Base
			respond_to :json
			before_filter :restrict_access
      attr_reader :current_user

	   private
    	def restrict_access
      		authenticate_or_request_with_http_token do |token, options|
        		User.exists?(token: token)
            if User.find_by_token(token)?
              @current_user = User.find_by_token(token)
            end
      		end

      		def request_http_token_authentication(realm = "Application")  
        		self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
        		self.__send__ :render, :json => { :error => "HTTP Token: Access denied. You did not provide a valid API key." }.to_json, :status => :unauthorized
      		end
    	end
		end
	end
end