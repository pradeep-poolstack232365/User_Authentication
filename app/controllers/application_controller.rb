class ApplicationController < ActionController::Base
	
	include JsonWebToken

	# before_action :authenticate_request
	skip_before_action :verify_authenticity_token
	private
	def authenticate_request
		# debugger
		header = request.headers["token"]
		header = header.split(" ").last if header
		decoded = jwt_decode(header)
		@current_user = User.find_by(id: decoded[:user_id])
		
	end
end
