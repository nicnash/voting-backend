class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	include ActionController::HttpAuthentication::Token::ControllerMethods
	before_filter :authenticate_user_from_token, except: [:token]


	def token
 		authenticate_with_http_basic do |email, password|
 		    user = User.find_by(email: email)
 		    if user && user.password == password
 		      render json: { token: user.auth_token }
 		    else
 		      render json: { error: 'Incorrect credentials' }, status: 401
 		    end
 		  end
	end

	 
	private
	 
	def authenticate_user_from_token
		unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token) }
	    	render json: { error: 'Bad Token'}, status: 401
	  	end
	end


    # For all responses in this controller, return the CORS access control headers.


	# def add_allow_credentials_headers                                                                                                                                                                                                                                                        
 #      # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5                                                                                                                                                                                                      
 #      #                                                                                                                                                                                                                                                                                       
 #      # Because we want our front-end to send cookies to allow the API to be authenticated                                                                                                                                                                                                   
 #      # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so                                                                                                                                                                                                      
 #      # the browser will not reject the response                                                                                                                                                                                                                                             
 #      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'                                                                                                                                                                                                     
 #      response.headers['Access-Control-Allow-Credentials'] = 'true'            
 #      response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'                                                                                                                                                                                                            
 #    end 

 #    def options                                                                                                                                                                                                                                                                              
 #      head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'                                                                                                                                                                                                         
 #    end
end
