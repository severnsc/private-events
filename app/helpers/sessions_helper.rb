module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def log_out
		session[:user_id] = nil
	end

	def redirect_user_or_default(default)
		if !session[:forwarding_url].nil?
			redirect_to session[:forwarding_url]
			session[:forwarding_url] = nil
		else
			redirect_to default
		end
	end

	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id:user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			@current_user = user
		end
	end

	def current_user?(user)
		user == current_user
	end

	def logged_in?
		!current_user.nil?
	end
end
